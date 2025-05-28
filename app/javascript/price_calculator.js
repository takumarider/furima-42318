 const price = () => {   
    const priceInput = document.getElementById("item-price");
    if (!priceInput) return; 
     priceInput.addEventListener("input", () => {
    const addTaxDom = document.getElementById("add-tax-price");
      addTaxDom.innerHTML = Math.floor(priceInput.value * 0.1 );
    const addProfitDom = document.getElementById("profit");
      addProfitDom.innerHTML = Math.floor(priceInput.value - Math.round(priceInput.value * 0.1 ))
    });
  };
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);