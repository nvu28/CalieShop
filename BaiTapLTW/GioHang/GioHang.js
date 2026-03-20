function selectSize(size, btn) {
    const cartItem = btn.closest(".cart-item");
    const hfSize = cartItem.querySelector("input[id$='hfSize']");
    if (hfSize) hfSize.value = size;

    const sizeInfo = cartItem.querySelector(".size-value");
    if (sizeInfo) {
        switch (size) {
            case "S": sizeInfo.innerHTML = "<b>S</b> (45-50kg; 150-155cm)"; break;
            case "M": sizeInfo.innerHTML = "<b>M</b> (48-54kg; 157-160cm)"; break;
            case "L": sizeInfo.innerHTML = "<b>L</b> (55-60kg; 160-165cm)"; break;
            case "XL": sizeInfo.innerHTML = "<b>XL</b> (60-70kg; 165-170cm)"; break;
        }
    }
}