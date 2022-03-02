const gallery = document.getElementById('gallery');

const modalImg = new bootstrap.Modal(document.getElementById("modalImage"), {});

function repositoryImage() {
    let img = '';
    let title = '';

    return {
        setImage: function (url) {
            img = url;
        },
        getImage: function () {
            return img;
        },
        setTitle: function (t) {
            title = t;
        },
        getTitle: function () {
            return title;
        }
    }
}
var image = repositoryImage();

gallery.addEventListener('click', function (e) {
    // Obtengo el índice del objetivo clickeado
    views.setPos([...this.children]
        .filter(el => el.className.indexOf('col') > -1)
        .indexOf(e.target.parentNode.parentNode));

    // Si se clickeo un objetivo válido y fue una imagen entonces...
    if (e.target && e.target.tagName === 'IMG' ) {

        // Guardar la imagen para pasarla al popup
        image.setImage(e.target.src);
        // Guardar el título para pasarlo al popup
        image.setTitle(e.target.parentNode.getElementsByClassName('card-text')[0].innerHTML);
        
        // Si la imagen se encuentra en una posición impar (de acuerdo a la vista)
        if (views.getPos() % 2 == 0) {
            window.open("./popup.html" , "popup" , "width=800,height=400,scrollbars=no,menubar=no,location=no,status=no,toolbar=no,help=no",);
        }
        else {
            views.addView();
            document.getElementById("modalContentImage").innerHTML='<img src="' + image.getImage() + '" />';
            modalImg.show();
        }
    }
});


// ------------------------------------------------------------------


let imgViews = document.getElementsByClassName('img-views');

function repositoryViews() {

    let v = [];
    let position = -1;

    return {
        loadViews: function() {
            if (localStorage.getItem('views')) {
                v = JSON.parse(localStorage.getItem('views'));
                // Si la cantidad de imágenes en la vista es superior a las almacenadas en localStorage...
                if ([...imgViews].length > v.length) {
                    for (let i = v.length; i < [...imgViews].length; i++) {
                        v.push('0');                    
                    }
                }
            } else {
                for (let i = 0; i < [...imgViews].length; i++) {
                    v[i] = '0';                    
                }
            }
        },

        drawViews: function() {
            if (v.length != 0) {
                let i = 0;
                [...imgViews].forEach(e => (e.innerHTML = v[i++]));
            } else {
                [...imgViews].forEach(e => (e.innerHTML = '0'));
            }
        },
        addView: function() {
            v[position]++;
            [...imgViews][position].innerHTML = v[position];
            localStorage.setItem('views',JSON.stringify(v));
        },
        setPos: function(pos) {
            position = pos
        },
        getPos: function() {
            if (position > -1) {
                return position;
            }
        }
    }
}

var views = repositoryViews();
views.loadViews();
views.drawViews();


// ------------------------------------------------------------------

const result = document.getElementById('textAjax');

function getTextJson() {
    let xhttp = new XMLHttpRequest();

    xhttp.open('GET','home.json',true);

    xhttp.send();

    xhttp.onreadystatechange = function() {
        if (this.readyState === 4 && this.status === 200) {
            let data = JSON.parse(this.responseText);
            result.value = data.texto;
        }
    }
}


