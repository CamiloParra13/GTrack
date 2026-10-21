public static class FechaLocal
{
    private static readonly TimeZoneInfo Colombia = Buscar();

    private static TimeZoneInfo Buscar()
    {
        foreach (var id in new[] { "America/Bogota", "SA Pacific Standard Time" })
        {
            try { return TimeZoneInfo.FindSystemTimeZoneById(id); }
            catch (TimeZoneNotFoundException) { }
            catch (InvalidTimeZoneException) { }
        }
        return TimeZoneInfo.CreateCustomTimeZone("COL", TimeSpan.FromHours(-5), "Colombia", "Colombia");
    }

    public static DateTime DesdeUtc(DateTime utc) =>
        TimeZoneInfo.ConvertTimeFromUtc(DateTime.SpecifyKind(utc, DateTimeKind.Utc), Colombia);
}
