-- Cambios sobre la BD gTrack para que coincida con el proyecto.
-- Se puede ejecutar varias veces sin problema.
USE gTrack;
GO

-- 1) Nombres del catalogo EstadoCuenta (el Id debe coincidir con el enum de C#)
UPDATE dbo.EstadoCuenta SET Nombre = Nombre + '_tmp' WHERE Nombre NOT LIKE '%[_]tmp';
UPDATE dbo.EstadoCuenta SET Nombre = CASE Id
  WHEN 0 THEN 'PendienteValidacion' WHEN 1 THEN 'Activo'
  WHEN 2 THEN 'Suspendido' WHEN 3 THEN 'Rechazado' WHEN 4 THEN 'Eliminado' END
WHERE Nombre LIKE '%[_]tmp';
GO

-- 2) Columna que usa NegocioService (CU-13)
IF COL_LENGTH('dbo.CodigoVerificacion', 'Verificado') IS NULL
    ALTER TABLE dbo.CodigoVerificacion
    ADD Verificado bit NOT NULL CONSTRAINT DF_CodVerif_Verificado DEFAULT (0);
GO

-- 3) Estado por defecto de una cuenta nueva = PendienteValidacion (0)
IF EXISTS (SELECT 1 FROM sys.default_constraints WHERE name = 'DF_Usuario_Estado')
    ALTER TABLE dbo.Usuario DROP CONSTRAINT DF_Usuario_Estado;
ALTER TABLE dbo.Usuario ADD CONSTRAINT DF_Usuario_Estado DEFAULT (0) FOR EstadoCuentaId;
GO
