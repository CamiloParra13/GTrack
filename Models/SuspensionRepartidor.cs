using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Gtrack;

[Table("SuspensionRepartidor")]
public class SuspensionRepartidor
{
    [Key]
    public int Id { get; set; }

    public int RepartidorId { get; set; }

    public int AdministradorId { get; set; }

    public string Motivo { get; set; } = string.Empty;

    public DateTime FechaSuspension { get; set; }

    public int? ReactivadoPorAdministradorId { get; set; }

    public DateTime? FechaReactivacion { get; set; }
}