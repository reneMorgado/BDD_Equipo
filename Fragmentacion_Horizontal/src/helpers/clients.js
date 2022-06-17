const querys = {
    getAllClients: "SELECT*FROM openquery(MYSQL,'SELECT  *FROM production.workorder limit 10;')"
};

module.exports = querys