
    function selectSize(size) {
        document.getElementById('<%= hfSize.ClientID %>').value = size;
    // đổi luôn dòng chữ
    const sizeInfo = document.querySelector(".size span:last-child");
    switch (size) {
      case "S": sizeInfo.textContent = "S (45-50kg; 150-155cm)"; break;
    case "M": sizeInfo.textContent = "M (48-54kg; 157-160cm)"; break;
    case "L": sizeInfo.textContent = "L (55-60kg; 160-165cm)"; break;
    case "XL": sizeInfo.textContent = "XL (60-70kg; 165-170cm)"; break;
    }
  }

