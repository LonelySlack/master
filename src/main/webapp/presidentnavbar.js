fetch('presidentnavbar.html')
.then(res => res.text())
.then(text => {
    let oldelem = document.querySelector("script#replace_with_presidentnavbar");
    let newelem = document.createElement("div");
    newelem.innerHTML = text;
    oldelem.parentNode.replaceChild(newelem,oldelem);
})