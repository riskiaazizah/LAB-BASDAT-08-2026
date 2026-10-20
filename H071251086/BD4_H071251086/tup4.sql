set search_path to classicmodels, public;

-- nomor 1
SELECT
	customernumber as "Identifikasi Pelanggan",
	SUM(amount) as "Total Setoran Dana",
	COUNT(checknumber) as "Frekuensi Transaksi",
	MAX(amount) as "Setoran Terbesar"
FROM payments
GROUP BY customernumber
HAVING COUNT(checknumber) > 4
	AND AVG(amount) > 20000;

-- nomor 2
SELECT
	customernumber as "Identifikasi Pelanggan",
	SUM(amount) as "Total Keseluruhan"
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 80000
ORDER BY SUM(amount) DESC;


-- nomor 3
SELECT
	productline AS "Kategori Barang",
	COUNT(productline) as "Jumlah Ragam Produk",
	ROUND(AVG(MSRP), 2) as "Rata-Rata Harga Jual",
	STRING_AGG(productname, ', ' ORDER BY productname ASC) as "Daftar Nama Produk"
FROM products
GROUP BY productline
HAVING COUNT(productline) > 10;


-- nomor 4
SELECT
	reportsto as "Nomor Identifikasi"
FROM employees
WHERE reportsto IS NOT NULL
EXCEPT 
SELECT employeenumber 
FROM employees
WHERE jobtitle LIKE '%VP%' or jobtitle LIKE '%President%';


-- nomor 5
SELECT 
	productcode as "Identifikasi barang",
	SUM(quantityordered) as "Total terjual",
	ROUND(AVG(priceeach), 2) as "Rata-rata"
FROM orderdetails
WHERE priceeach > 100
GROUP BY productcode
HAVING SUM(quantityordered) > 50 
ORDER BY SUM(quantityordered) DESC;


-- nomor 6
SELECT
	productcode,
	SUM(quantityordered) as "Total Unit Dipesan",
	SUM(quantityordered * priceeach) as "Estimasi Harga",
	AVG(ROUND(priceeach, 2)) as "Rata-Rata",
	(MAX(priceeach) - MIN(priceeach)) as "Rentang"
FROM orderdetails
WHERE quantityOrdered > 20
GROUP BY productcode
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY "Estimasi Harga" DESC;

-- nomor 7
(SELECT customernumber
FROM customers
WHERE creditlimit > 80000

INTERSECT

SELECT customernumber
FROM orders
WHERE status = 'Cancelled'
OR status = 'On Hold')

EXCEPT
SELECT customernumber
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 100000;

	
	


	
	