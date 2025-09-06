import { test, expect } from 'vitest';
import { toOrchestratorPayload } from './index';

test('maps RescuePlan spec to orchestrator payload with defaults', () => {
  const payload = toOrchestratorPayload({ action: 'backup' });
  expect(payload).toEqual({ action: 'backup', target: 'primary', schedule: null });
});

test('respects provided target and schedule', () => {
  const payload = toOrchestratorPayload({ action: 'failover', targetCluster: 'dr', schedule: '*/10 * * * *' });
  expect(payload).toEqual({ action: 'failover', target: 'dr', schedule: '*/10 * * * *' });
});
