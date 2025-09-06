import Fastify from 'fastify';
import { ORCH_URL } from './config.js';

const app = Fastify({ logger: true });

// Root hint
app.get('/', async () => ({
  hello: 'kRescue API',
  try: ['/status', '/o/status', 'POST /o/backup'],
}));

// API health
app.get('/status', async () => ({ ok: true, service: 'api', version: '0.1.0' }));

// Proxy: orchestrator /status
app.get('/o/status', async (_req, reply) => {
  try {
    const res = await fetch(`${ORCH_URL}/status`);
    reply.header('content-type', 'application/json');
    return await res.json();
  } catch (err) {
    reply.code(502);
    return { ok: false, error: 'orchestrator_unreachable', detail: (err as Error).message };
  }
});

// Proxy: orchestrator /backup (POST)
app.post('/o/backup', async (_req, reply) => {
  try {
    const res = await fetch(`${ORCH_URL}/backup`, { method: 'POST' });
    reply.header('content-type', 'application/json');
    return await res.json();
  } catch (err) {
    reply.code(502);
    return { ok: false, error: 'orchestrator_unreachable', detail: (err as Error).message };
  }
});

const port = Number(process.env.PORT || 8080);
const host = '0.0.0.0';

app
  .listen({ port, host })
  .then(() => {
    console.log(`[api] listening on http://${host}:${port} (ORCH_URL=${ORCH_URL})`);
  })
  .catch((err) => {
    console.error('[api] failed to start', err);
    process.exit(1);
  });
