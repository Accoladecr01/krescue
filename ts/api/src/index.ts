import Fastify from 'fastify';

const app = Fastify();

// simple health endpoint
app.get('/status', async () => ({ ok: true, service: 'api', version: '0.1.0' }));

// start server
app.listen({ port: 8080, host: '0.0.0.0' }).then(() => {
  console.log('[api] listening on http://localhost:8080');
});
