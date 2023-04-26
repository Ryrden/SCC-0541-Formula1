const fs = require('fs');

const nullValue = '\\N';

const csvDirectory = './database';
const insertsDirectory = './inserts';

/**
 * Read a CSV file and return an array of objects
 * 
 * @param {*} file 
 * @returns object[]
 */
const readCSV = (file) => {
    const [headerLine, ...contentLines] = file.split('\n');
    const headers = parseHeaders(headerLine);
    const csvParsed = contentLines.map((line) => parseLine(line, headers));

    return [csvParsed, headers];

    function parseHeaders(headerLine) {
        return headerLine.split(',').map((header) => header.replace(/"/g, ''));
    };

    function parseLine(line, headers) {
        const values = line.split(',').map((value) => value.replace(/"/g, ''));
        const hasExtraValues = values.length > headers.length;

        if (hasExtraValues) {
            const remainingValues = values.slice(headers.length - 1);
            const lastValue = remainingValues.join(',');
            values[headers.length - 1] = lastValue;
        }

        const obj = {};
        headers.forEach((header, index) => {
            obj[header] = isNullOrEmpty(values[index]) ? 'null' : values[index];
        });

        return obj;
    };

    function isNullOrEmpty(value) {
        return value === nullValue || value === '';
    };
};

/**
 * Convert Object to SQL Insert Statement
 * 
 * @param {*} object 
 * @param {*} headers 
 * @returns string[]
 */
const convertToSQLInsertStatement = (object, headers, databaseName) => {
    return object.map((row) => {
        const values = headers.map((header) => quoteIfNeeded(row[header]));
        const sql = `INSERT INTO ${databaseName} (${headers.join(',')}) VALUES (${values.join(',')})`;
        return sql;
    });

    function quoteIfNeeded(value) {
        if (isNaN(value) && value !== 'null') {
            return `"${value}"`;
        }
        return value;
    };
};

const main = () => {
    const csvFiles = getCsvFiles(csvDirectory);
    createInsertsDirectory(insertsDirectory);

    csvFiles.forEach((csvFile) => {
        const databaseName = getDatabaseName(csvFile);
        console.log(`Reading ${databaseName}...`);
        const csvContent = fs.readFileSync(`${csvDirectory}/${csvFile}`, 'utf8');
        const [csvParsed, headers] = readCSV(csvContent);
        const sqlInserts = convertToSQLInsertStatement(csvParsed, headers, databaseName);
        console.log(`Writing ${databaseName} inserts...`);
        writeSqlInserts(sqlInserts, databaseName, insertsDirectory);
    });

    function getCsvFiles(directory) {
        const files = fs.readdirSync(directory);
        return files.filter((file) => file.endsWith('.csv'));
    };

    function createInsertsDirectory(directory) {
        if (!fs.existsSync(directory)) {
            fs.mkdirSync(directory);
        }
    };

    function getDatabaseName(csvFile) {
        return csvFile.split('.')[0];
    };

    function writeSqlInserts(sqlInserts, databaseName, directory) {
        const fileName = `${databaseName}_inserts.sql`.toUpperCase();
        const filePath = `${directory}/${fileName}`;
        fs.writeFileSync(filePath, '');
        sqlInserts.forEach((sql) => {
            fs.appendFileSync(filePath, sql + '\n');
        });
    };
};

main();