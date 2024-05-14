function item() {
  const priceInput = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const addProfit = document.getElementById('profit');
  const priceError = document.getElementById('price-error');

  priceInput.addEventListener('input', () => {
    const priceValue = priceInput.value.trim();
    // 正規表現を使って半角数字のみかチェック
    if (priceValue && /^\d+$/.test(priceValue)) {
      const price = parseInt(priceValue);
      const taxPrice = Math.floor(price * 0.1);
      addTaxPrice.textContent = `${taxPrice}`;  // カンマ区切りで表示する場合は`toLocaleString()`を使用
      addProfit.textContent = `${price - taxPrice}`;
      priceError.style.display = 'none';
    } else {
      addTaxPrice.textContent = ''; // 手数料をクリア
      addProfit.textContent = ''; // 利益をクリア
      priceError.textContent = '半角数字を入力してください。'; // エラーメッセージを更新
      priceError.style.display = 'block'; // エラーメッセージを表示
    }
  });
}

window.addEventListener('turbo:load', item);