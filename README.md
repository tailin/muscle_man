# Muscle-man 💪

這是一個基於 [kamigo](https://github.com/etrex/kamigo) 實作來紀錄重訓數據的==肌肉仔==聊天機器人


## Why use

在健身的過程中飲食固然重要，但往往訓練的人都是透過通靈的方法來選取適合自己的訓練重量，而透過數據的記載則是突破不可或缺的因素，因此產生了這個 muscle-man 機器人，藉由他讓數據能夠被存取以及查詢，讓自己的訓練可以更有效率🎉


## Add me

![qrcode](https://i.imgur.com/Oy0B2W2m.png)

## Snapshot

### 今日訓練表單：
![root path](https://i.imgur.com/UuGsHZ7m.png)

### 訓練類別細項：
![show path](https://i.imgur.com/brPFPrwm.png)

### 新增訓練項目(類型/動作/次數/組數/組間/重量)：
![create path](https://i.imgur.com/MVaCBhWl.png)

### 查詢近期訓練項目(前N個月/項目)：
![find path](https://i.imgur.com/X9Iqtpol.png)

---

# If you want to use Muscle-man

## Enviroments

* ruby 2.5.0
* rails 5.2.3
* kamigo 0.2.2

## Base settings

1. 建立與設定環境變數 `.env`

```
LINE_CHANNEL_SECRET=這裡填入你的 LINE_CHANNEL_SECRET
LINE_CHANNEL_TOKEN=這裡填入你的 LINE_CHANNEL_TOKEN
LIFF_COMPACT=這裡填入你的 LIFF_COMPACT
LIFF_TALL=這裡填入你的 LIFF_TALL
LIFF_FULL=這裡填入你的 LIFF_FULL
LINE_LOGIN_ID=填入LINE_LOGIN_ID
LINE_LOGIN_KEY=填入LINE_SECRET_ID
LINE_LOGIN_URI=https://{YOUR_URL}/users/line_login
AUTH_NAME=admin
AUTH_PASSWORD=admin
```

*若是使用`Heroku`部署的話需要至紅色箭頭位置設定環境變數*

![heroku](https://i.imgur.com/byDFwHa.png)


2. 設定 LINE Message Bot Webhook
```
https://你的網域/line
```

3. 將網址 `https://{YOUR_URL}/users/auth` 轉成 QR Code 讓使用者掃描加入。

## LISENCE
MIT
