-- CU-17 Cancelar Pedido (cliente): tabla con el motivo de cada cancelacion.
-- Ejecutar una vez sobre la BD gTrack (se puede ejecutar varias veces sin problema).
-- En el hosting, si la base tiene otro nombre, cambia o quita la linea USE.
USE gTrack;
GO

IF OBJECT_ID('dbo.SolicitudCancelacion', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.SolicitudCancelacion (
        Id             int IDENTITY(1,1) NOT NULL CONSTRAINT PK_SolicitudCancelacion PRIMARY KEY,
        PedidoId       int               NOT NULL CONSTRAINT FK_SolicitudCancelacion_Pedido REFERENCES dbo.Pedido (Id),
        Motivo         nvarchar(250)     NOT NULL,
        FechaSolicitud datetime2         NOT NULL CONSTRAINT DF_SolicitudCancelacion_Fecha DEFAULT (SYSUTCDATETIME()),
        -- RN-1-CU17: solo una solicitud de cancelacion por pedido
        CONSTRAINT UQ_SolicitudCancelacion_Pedido UNIQUE (PedidoId)
    );
END
GO
