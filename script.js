const fs = require('fs');

const nullValue = '\\N';

// Read the file
const csvFilename = process.argv[2];
const file = fs.readFileSync(csvFilename, 'utf8');

const csvParsed = readCSV(file);
console.log(csvParsed)
const headers = Object.keys(csvParsed[0]);
const sql = convertToSQLInsertStatement(csvParsed, headers);
//console.log(sql);

// TODO: Tratar espaços vazios em Values
// TODO: Tratar Datas de inserção
// TODO: Tratar caracteres especiais 

/**
 * Read a CSV file and return an array of objects
 * 
 * @param {*} file 
 * @returns object[]
 */
function readCSV(file) {
    const lines = file.split("\n");
    const headers = lines[0].split(",").map(header => header.replace(/"/g, ''));
    const csvParsed = [];

    lines.shift(); // Remove headers
    for (const line of lines) {
        const currentline = line.split(",").map(value => value.replace(/"/g, ''));
        const obj = {};
    
        for (const [index, header] of headers.entries()) {
            obj[header] = currentline[index] != nullValue ? currentline[index] : null;
        }
        
        csvParsed.push(obj);
    }

    return csvParsed;
}

/**
 * Convert Object to SQL Insert Statement
 * 
 * @param {*} object 
 * @param {*} headers 
 * @returns string[]
 */
function convertToSQLInsertStatement(object, headers) {
    const sql = [];
    const csvFilename = process.argv[2].split('/')[1].split('.')[0];
    for(const row of object) {
        for(const header of headers) {
            if (isNaN(row[header])) {
                row[header] = `'${row[header]}'`;
            }else{
                row[header] = `${row[header]}`;
            }
        }
        sql.push(`INSERT INTO ${csvFilename} (${headers.join(',')}) VALUES (${Object.values(row).join(",")})`);
    }
    return sql;
}
