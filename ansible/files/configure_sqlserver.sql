DECLARE @total_mem_mb INT;
SELECT @total_mem_mb = total_physical_memory_kb/1024 FROM sys.dm_os_sys_memory;
DECLARE @max_mem_mb INT = (@total_mem_mb * 9) / 10;

EXEC sys.sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sys.sp_configure 'max server memory (MB)', @max_mem_mb;
RECONFIGURE;
EXEC sys.sp_configure 'max degree of parallelism', 4;
RECONFIGURE;
EXEC sys.sp_configure 'cost threshold for parallelism', 50;
RECONFIGURE;

DECLARE @current INT = (SELECT COUNT(*) FROM tempdb.sys.database_files WHERE type_desc='ROWS');
DECLARE @desired INT = 8;
WHILE @current < @desired
BEGIN
    DECLARE @name NVARCHAR(128) = 'tempdev' + CAST(@current+1 AS NVARCHAR(10));
    DECLARE @path NVARCHAR(260) = (SELECT TOP 1 physical_name FROM tempdb.sys.database_files WHERE type_desc = 'ROWS');
    SET @path = LEFT(@path, LEN(@path) - CHARINDEX('\\', REVERSE(@path))) + '\\' + @name + '.ndf';
    DECLARE @sql NVARCHAR(4000) = 'ALTER DATABASE tempdb ADD FILE (NAME = ' + QUOTENAME(@name) + ', FILENAME = ''' + @path + ''', SIZE = 64MB, FILEGROWTH = 64MB)';
    EXEC (@sql);
    SET @current = @current + 1;
END
GO
