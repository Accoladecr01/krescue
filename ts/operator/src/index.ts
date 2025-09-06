import k8s from '@kubernetes/client-node';

// Load kubeconfig from the usual locations (~/.kube/config or in-cluster)
const kc = new k8s.KubeConfig();
kc.loadFromDefault();

console.log('[operator] starting (placeholder)…');

// --- Domain model for our CRD spec ---
export type Action = 'backup' | 'restore' | 'failover';
export type Target = 'primary' | 'dr';

export interface RescuePlanSpec {
  schedule?: string;          // e.g., "*/5 * * * *" (optional)
  action: Action;             // what to do
  targetCluster?: Target;     // where; default 'primary'
}

// Map a RescuePlan spec to a payload the orchestrator will accept (later)
export function toOrchestratorPayload(spec: RescuePlanSpec) {
  return {
    action: spec.action,
    target: spec.targetCluster ?? 'primary',
    schedule: spec.schedule ?? null
  };
}
