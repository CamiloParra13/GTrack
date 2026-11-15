using Microsoft.AspNetCore.Mvc.ModelBinding;
using System.Globalization;

// Los decimales que llegan de formularios y de JavaScript siempre usan punto ("4.5981", "12.50").
// Sin este binder, ASP.NET los interpreta con la cultura del servidor: en es-CO el punto es separador de miles,
// así que "4.5981" se leía como 45981 (coordenada inválida) y "12.50" como 1250 (precio 100 veces mayor).
public class InvariantDecimalModelBinder(bool admiteNulo) : IModelBinder
{
    public Task BindModelAsync(ModelBindingContext bindingContext)
    {
        var resultado = bindingContext.ValueProvider.GetValue(bindingContext.ModelName);
        if (resultado == ValueProviderResult.None) return Task.CompletedTask;

        bindingContext.ModelState.SetModelValue(bindingContext.ModelName, resultado);
        var texto = resultado.FirstValue?.Trim();

        if (string.IsNullOrEmpty(texto))
        {
            if (admiteNulo) bindingContext.Result = ModelBindingResult.Success(null);
            else bindingContext.ModelState.TryAddModelError(bindingContext.ModelName, "Campo obligatorio");
            return Task.CompletedTask;
        }

        if (decimal.TryParse(texto, NumberStyles.AllowLeadingSign | NumberStyles.AllowDecimalPoint,
                CultureInfo.InvariantCulture, out var valor))
            bindingContext.Result = ModelBindingResult.Success(valor);
        else
            bindingContext.ModelState.TryAddModelError(bindingContext.ModelName, "Ingresa un número válido");

        return Task.CompletedTask;
    }
}

public class InvariantDecimalModelBinderProvider : IModelBinderProvider
{
    public IModelBinder? GetBinder(ModelBinderProviderContext context) =>
        context.Metadata.UnderlyingOrModelType == typeof(decimal)
            ? new InvariantDecimalModelBinder(context.Metadata.IsNullableValueType)
            : null;
}
