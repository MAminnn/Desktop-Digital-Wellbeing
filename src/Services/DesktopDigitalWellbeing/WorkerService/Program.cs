using Serilog;
using WorkerService;

Log.Logger = new LoggerConfiguration().MinimumLevel.Debug()
    .MinimumLevel.Override("Microsoft", Serilog.Events.LogEventLevel.Warning)
    .Enrich.FromLogContext()
    .WriteTo.File(@"Z:\log.txt")
    .CreateLogger();

IHost host = Host.CreateDefaultBuilder(args)
    .UseWindowsService()
    .ConfigureServices(services =>
    {
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
