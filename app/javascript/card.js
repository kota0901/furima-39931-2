const pay = () => {
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  // Elementsをマウントする既存のHTML要素に対応するIDを使用
  const cardNumberElement = elements.create('cardNumber');
  cardNumberElement.mount('#card-number');  // カード番号入力フィールド

  const cardExpiryElement = elements.create('cardExpiry');
  cardExpiryElement.mount('#card-exp-month'); // 有効期限入力フィールド。注意: 通常は月と年を別々に扱いますが、Elementsでは一つの入力フィールドで処理します。

  const cardCvcElement = elements.create('cardCvc');
  cardCvcElement.mount('#card-cvc'); // CVC入力フィールド

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    // トークンを生成し、サーバーへ送信
    payjp.createToken(cardNumberElement).then(function (response) {
      if (response.error) {
        console.error(response.error.message);  // エラー処理を追加
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);

        form.submit();  // トークンを付与した後、フォームをサブミット
      }
    });
  });
};

window.addEventListener("turbo:load", pay);
