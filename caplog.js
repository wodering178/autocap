const { chromium } = require('playwright');

(async () => {

  const url = process.argv[2];
  const outfile = process.argv[3];

  const browser = await chromium.launch({
    headless: true
  });

  const context = await browser.newContext({
    storageState: "auth.json"
  });

  const page = await context.newPage();

  await page.goto(url);

  await page.waitForTimeout(5000);

  const timestamp = new Date().toISOString().replace("T"," ").slice(0,19);

  await page.evaluate((ts) => {
    const overlay = document.createElement("div");
    overlay.textContent = "Captured: " + ts;

    overlay.style.position = "fixed";
    overlay.style.top = "10px";
    overlay.style.right = "10px";
    overlay.style.background = "rgba(0,0,0,0.7)";
    overlay.style.color = "white";
    overlay.style.padding = "6px 10px";
    overlay.style.fontSize = "14px";
    overlay.style.fontFamily = "monospace";
    overlay.style.borderRadius = "4px";
    overlay.style.zIndex = "999999";

    document.body.appendChild(overlay);
  }, timestamp);

  await page.screenshot({ path: outfile });

  await browser.close();

})();
