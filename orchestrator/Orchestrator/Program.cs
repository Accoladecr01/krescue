using System;

var builder = WebApplication.CreateBuilder(args);
builder.WebHost.UseUrls("http://0.0.0.0:8090"); // always listen on 8090

var app = builder.Build();

// Root hint
app.MapGet("/", () => Results.Json(new { hello = "kRescue orchestrator", hint = "/status" }));

// Health/status
app.MapGet("/status", () => Results.Json(new
{
    ok = true,
    service = "orchestrator",
    version = "0.1.0"
}));

// Backup (dry-run)
app.MapPost("/backup", () =>
{
    var name = $"backup-{DateTime.UtcNow:yyyyMMdd-HHmmss}";
    return Results.Json(new
    {
        ok = true,
        mode = "dry-run",
        backupName = name,
        startedAtUtc = DateTime.UtcNow
    });
});

app.Run();
