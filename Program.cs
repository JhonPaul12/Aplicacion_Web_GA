using Serilog;
using Prometheus;

var builder = WebApplication.CreateBuilder(args);

//Configurar Serilog 
builder.Host.UseSerilog((context, services, configuration) => {
    configuration
        .ReadFrom.Configuration(context.Configuration)
        .ReadFrom.Services(services)
        .Enrich.FromLogContext();
});

//Agregar servicios necesarios antes del build
builder.Services.AddRazorPages();

var app = builder.Build();

//Configurar middleware 
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseHttpMetrics(); //Middleware de Prometheus

app.UseAuthorization();

//Mapear páginas y métricas
app.UseEndpoints(endpoints =>
{
    endpoints.MapRazorPages();
    endpoints.MapMetrics(); // Exponer métricas en /metrics
});

app.Run();
