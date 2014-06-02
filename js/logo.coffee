define ->
  drawLogo: ->
    svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");

    svg.setAttributeNS null, "viewBox", "0 0 17500 16500";
    svg.setAttributeNS null, "width", "300px";
    svg.setAttributeNS null, "height", "300px";
    svg.style.display = "inline-block";

    svg.innerHTML = '<circle class="fil0" cx="12147" cy="11322" r="5000"/>
      <circle class="fil1" cx="5038" cy="5023" r="5000"/>
      <circle class="fil2" cx="5053" cy="11477" r="5000"/>
      <circle class="fil3" cx="12462" cy="5136" r="5000"/>
      <rect class="fil4" x="5082" y="7033" width="6985" height="6985"/>
      <rect class="fil4" x="3567" y="2675" width="2500" height="2500"/>
      <rect class="fil4" x="11163" y="2641" width="2500" height="2500"/>
      <rect class="fil4" x="7270" y="2731" width="2500" height="2500"/>
      <polygon class="fil4" points="13669,5074 3527,5146 5093,7136 12052,7126 "/>';

    document.querySelector("#welcome").appendChild(svg);