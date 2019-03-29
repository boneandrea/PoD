// ?url=_URL_ のスクショをbase64してjsonで返す

// ローカルではこれで問題なく動作する

const puppeteer = require("puppeteer")

module.exports = async function(context, req) {
  context.log("JavaScript HTTP trigger function processed a request.")
  if (req.query.url) {
    const url = req.query.url

    context.log(url)
    const browser = await puppeteer.launch({
      args: ["--no-sandbox", "--disable-setuid-sandbox"]
    })
    const page = await browser.newPage()
    await page.goto(url)
    const base64 = await page.screenshot({encoding: "base64"})

    context.log(base64)
    browser.close()

    context.res = {
      headers: {
        "content-type": "application/json"
      },
      body: {
        msg: "Hello;" + url,
        body: base64
      }
    }
  } else {
    context.res = {
      status: 400,
      body: "Please pass a name on the query string or in the request body"
    }
  }
}
