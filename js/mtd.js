/**
 * Created by tivvit on 29.05.14.
 */

requirejs.config({
    baseUrl: 'js'
});

requirejs(['game'],
    function (game) {
        alert("all loaded")
    }
);