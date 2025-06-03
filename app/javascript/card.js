const pay = () => {
  const numberForm = document.getElementById('card-number-form');
  const expiryForm = document.getElementById('card-expiry-form');
  const cvcForm = document.getElementById('card-cvc-form');

  const payjp =  Payjp(gon.payjp_public_key);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');
  numberElement.mount('#card-number-form');
  expiryElement.mount('#card-expiry-form');
  cvcElement.mount('#card-cvc-form');

  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    payjp.createToken(numberElement).then(function(response) {
      if (response.error) {
      }else {
        const token = response.id;
        const tokenInput = document.createElement("input");
        tokenInput.setAttribute("type", "hidden");
        tokenInput.setAttribute("name", "order_address[token]");
        tokenInput.setAttribute("value", token);
        form.appendChild(tokenInput);
        
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();

        
      }
      form.submit();
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
