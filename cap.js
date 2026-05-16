// cap.js
const { chromium } = require('playwright');

(async () => {
  const url = process.argv[2];
  const outfile = process.argv[3];

  if (!url || !outfile) {
    console.log("Usage: node capture.js <url> <outputfile>");
    process.exit(1);
  }

  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();

  await page.goto(url);

// đợi trang load thêm
await page.waitForTimeout(5000);

// tạo timestamp
const timestamp = new Date().toLocaleString();

// chèn overlay timestamp vào trang
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

// chụp ảnh
await page.screenshot({ path: outfile });

  await browser.close();
})();
