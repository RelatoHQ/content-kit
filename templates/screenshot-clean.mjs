import { chromium } from 'playwright';

const url = process.argv[2];
const out = process.argv[3];

if (!url || !out) {
  console.error('Usage: node screenshot-clean.mjs <url> <output.png>');
  process.exit(1);
}

const browser = await chromium.launch({ headless: true });
const context = await browser.newContext({
  viewport: { width: 1280, height: 1800 },
});
const page = await context.newPage();

await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 30000 });

// Try common cookie-consent dismissal patterns
const acceptSelectors = [
  '#wcpConsentBannerCtl button:has-text("Accept")',
  'button#bnp_btn_accept',
  'button[aria-label*="Accept"]',
  'button:has-text("Accept all")',
  'button:has-text("Accept All")',
  'button:has-text("Accept")',
  'button:has-text("I Accept")',
  'button:has-text("OK")',
  '[data-testid*="accept"]',
  '[id*="accept-cookies"]',
  '[class*="accept-cookies"]',
];

for (const sel of acceptSelectors) {
  try {
    const el = await page.$(sel);
    if (el) {
      await el.click({ timeout: 2000 });
      console.error(`clicked: ${sel}`);
      await page.waitForTimeout(800);
      break;
    }
  } catch {}
}

// Aggressive cleanup of any remaining overlay/modal elements
await page.evaluate(() => {
  const killSelectors = [
    '#wcpConsentBannerCtl',
    '#bnp_container',
    '[id*="cookie" i][class*="banner" i]',
    '[id*="consent" i]',
    '[aria-label*="cookie" i]',
    '[role="dialog"][aria-label*="cookie" i]',
    '.onetrust-banner-sdk',
    '#onetrust-banner-sdk',
    '#CybotCookiebotDialog',
    '.cc-window',
    '.cookie-notice',
    '.gdpr-banner',
  ];
  for (const sel of killSelectors) {
    document.querySelectorAll(sel).forEach((el) => el.remove());
  }
  // Also clear any fixed overlays at top of viewport
  document.querySelectorAll('*').forEach((el) => {
    const cs = getComputedStyle(el);
    if (cs.position === 'fixed' && parseInt(cs.top || '0') < 50) {
      const text = (el.innerText || '').toLowerCase();
      if (text.includes('cookie') || text.includes('consent') || text.includes('gdpr')) {
        el.remove();
      }
    }
  });
});

await page.waitForTimeout(500);

await page.screenshot({ path: out, fullPage: false });
await browser.close();
console.error(`saved: ${out}`);
