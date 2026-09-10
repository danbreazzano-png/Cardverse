export function passportCode() {
  const n = Math.floor(100000 + Math.random() * 900000);
  return `CV-${n}`;
}

export function dealScore(price: number, low: number, high: number) {
  if (!price || !high) return 50;
  const midpoint = (low + high) / 2;
  const ratio = price / midpoint;
  return Math.max(1, Math.min(100, Math.round(100 - Math.max(0, ratio - 0.5) * 100)));
}