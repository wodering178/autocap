const { chromium } = require('playwright');
const readline = require('readline');

(async () => {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  try {
    const browser = await chromium.launch({ headless: false });
    const context = await browser.newContext();
    const page = await context.newPage();

    await page.goto("https://example.com/login");

    console.log("Please login manually in the browser...");

    await new Promise((resolve) => {
      rl.question("After login success, press ENTER here.\n", () => resolve());
    });

    await context.storageState({ path: "auth.json" });
    console.log("Login session saved to auth.json");

    rl.close();
    process.stdin.pause();

    setTimeout(() => {
      process.exit(0);
    }, 50);

  } catch (err) {
    console.error(err);
    try { rl.close(); } catch {}
    try { process.stdin.pause(); } catch {}
    setTimeout(() => {
      process.exit(1);
    }, 50);
  }
})();
