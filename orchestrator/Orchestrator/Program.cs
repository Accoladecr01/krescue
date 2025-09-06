using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

var builder = WebApplication.CreateBuilder(args);

// Structured JSON logs
builder.Logging.ClearProviders();
builder.Logging.AddJsonConsole();

// Background worker
builder.Services.AddHostedService<HeartbeatWorker>();

var app = builder.Build();

// ---- ENDPOINTS (top-level statements come first) ----

// Health/status
app.MapGet("/status", () => Results.Json(new
{
    ok = true,
    service = "orchestrator",
    version = "0.1.0"
}));

// /backup (dry-run for now)
app.MapPost("/backup", (BackupRequest? req) =>
{
    var mode = Environment.GetEnvironmentVariable("DRY_RUN") == "0" ? "live" : "dry-run";
    var name = Helpers.NewBackupName();

    if (mode == "dry-run")
    {
        return Results.Json(new BackupResponse(
            Ok: true,
            Mode: mode,
            BackupName: name,
            StartedAtUtc: DateTime.UtcNow
        ));
    }

    return Results.Json(new { ok = false, error = "live mode not implemented yet" });
});

app.Run();


// ---- TYPE DECLARATIONS MUST COME AFTER TOP-LEVEL STATEMENTS ----

public static class Helpers
{
    public static string NewBackupName() => $"backup-{DateTime.UtcNow:yyyyMMdd-HHmmss}";
}

public record BackupRequest(string Namespace = "krescue-primary", string? LabelSelector = "app=sample-app");
public record BackupResponse(bool Ok, string Mode, string BackupName, DateTime StartedAtUtc);

public class HeartbeatWorker : BackgroundService
{
    private readonly ILogger<HeartbeatWorker> _logger;
    public HeartbeatWorker(ILogger<HeartbeatWorker> logger) => _logger = logger;

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            _logger.LogInformation("orchestrator alive at {Time}", DateTimeOffset.Now);
            await Task.Delay(TimeSpan.FromSeconds(30), stoppingToken);
        }
    }
}
