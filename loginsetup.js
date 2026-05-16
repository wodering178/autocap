const { chromium } = require('playwright');

(async () => {

  const browser = await chromium.launch({
    headless: false   // mở browser thật để bạn login
  });

  const context = await browser.newContext();
  const page = await context.newPage();

  // URL trang login
  await page.goto("https://example.com/login");

  console.log("Please login manually in the browser...");
  console.log("After login success, press ENTER here.");

  // chờ bạn login xong
  await new Promise(resolve => process.stdin.once("data", resolve));

  // lưu session
  await context.storageState({ path: "auth.json" });

  console.log("Login session saved to auth.json");

  await browser.close();

})();
