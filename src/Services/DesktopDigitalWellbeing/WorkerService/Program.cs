using Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;
using Serilog;
using WorkerService;

Log.Logger = new LoggerConfiguration().MinimumLevel.Debug()
    .MinimumLevel.Override("Microsoft", Serilog.Events.LogEventLevel.Warning)
    .Enrich.FromLogContext()
    .WriteTo.File(Path.Combine(Directory.GetCurrentDirectory(), "logs.txt"))
    .CreateLogger();




IHost host = Host.CreateDefaultBuilder(args)
    .UseWindowsService()
    .ConfigureServices(services =>
    {
        services.AddDbContext<DWDbContext>();
        #region Migration
        var provider = services.BuildServiceProvider();
        var context = provider.GetRequiredService<DWDbContext>();
        context.Database.OpenConnection();
        context.Database.Migrate();
        #endregion
        services.AddHostedService<Worker>();
    }).UseSerilog()
    .Build();

try
{
    Log.Information("Starting the service ...");
    host.Run();
    Log.Information("Service stopped");
    return;
}
catch (Exception ex)
{
    Log.Fatal(ex, "There was problem starting the service");
    return;
}
