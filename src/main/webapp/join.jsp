<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../../../favicon.ico">

    <title>Sign Up Page</title>

    <!-- Bootstrap core CSS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>


    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.3/css/materialize.min.css'>
    <link rel='stylesheet' href='https://fonts.googleapis.com/icon?family=Material+Icons'>


<script src='//static.codepen.io/assets/editor/live/console_runner-ce3034e6bde3912cc25f83cccb7caa2b0f976196f2f2d52303a462c826d54a73.js'>
</script>
<script src='//static.codepen.io/assets/editor/live/css_live_reload_init-654f8ff86ff57fe42b9638d3bacf774c90ce371a1c6d0ae81f5d12823b0334eb.js'>
</script>

    <!-- Custom styles for this template -->
  <!--   <link href="css/joinning.css" rel="stylesheet"> -->
<script src='//static.codepen.io/assets/editor/live/console_runner-ce3034e6bde3912cc25f83cccb7caa2b0f976196f2f2d52303a462c826d54a73.js'>
</script><script src='//static.codepen.io/assets/editor/live/css_live_reload_init-654f8ff86ff57fe42b9638d3bacf774c90ce371a1c6d0ae81f5d12823b0334eb.js'>
</script><meta charset='UTF-8'><meta name="robots" content="noindex">
<link rel="shortcut icon" type="image/x-icon" href="//static.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" />
<link rel="mask-icon" type="" href="//static.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg" color="#111" />
<link rel="canonical" href="https://codepen.io/vaskopetrov/pen/amxvrY" />

<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.3/css/materialize.min.css'>
<link rel='stylesheet' href='https://fonts.googleapis.com/icon?family=Material+Icons'>
<style class="cp-pen-styles">

    
  body {
  background: #222;
  background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://unsplash.it/1200/800/?random');
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center center;
  background-fill-mode: rgba(0,0,0,0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}
.container {
  background: white;
  padding: 20px 25px;
  border: 5px solid #26a69a;
  width: 550px;
  height: auto;
  box-sizing: border-box;
  position: relative;
}
.col.s6 > .btn {
   width: 100%;
}
.gender-male,.gender-female {
  display: inline-block;
}
.gender-female {
  margin-left: 35px;
}
radio:required {
  border-color: red;
  opacity: 0;
}
.container {
  animation: showUp 0.5s cubic-bezier(0.18, 1.3, 1, 1) forwards;
}

@keyframes showUp {
  0% {
    transform: scale(0);
  }
  100% {
    transoform: scale(1);
  }
}
.row {margin-bottom: 10px;}

.ngl {
  position: absolute;
  top: -20px;
  right: -20px;
}

    </style>
    
</head>

<body>
   
<div class="container">
<div class="row">
    <form class="col s12" id="reg-form">
      <div class="row">
        <div class="input-field col s6">
          <input id="id" type="text" class="validate" required autofocus>
          <label for="id">Input Your ID</label>
        </div>
        <div class="input-field col s6">
          <input id="pw" type="password" class="validate" required>
          <label for="pw">Input Your PassWord</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="email" type="email" class="validate" required>
          <label for="email">Email</label>
        </div>
      </div>
        <div class="row">
        <div class="input-field col s12">
          <input id="nick" type="text" class="validate" required>
          <label for="nick">Nick Name</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s12">
          <input id="phone" type="text" class="validate" minlength="6" required>
          <label for="phone">Input Your Phone Number</label>
        </div>
      </div>
      <div class="row">
        <div class="input-field col s6">
          <div class="gender-male">
            <input class="with-gap" name="gender" type="radio" id="male" value="1" required />
            <label for="male">Male</label>
          </div>
          <div class="gender-female">
            <input class="with-gap" name="gender" type="radio" id="female" value="2" required />
            <label for="female">Female</label>
          </div>
        </div>

        <div class="input-field col s6">
          <button class="btn btn-large btn-register waves-effect waves-light" type="button" name="action">Register
            <i class="material-icons right">done</i>
          </button>
        </div>
      </div>
    </form>
  </div>
  <a title="Login" class="ngl btn-floating btn-large waves-effect waves-light red"><i class="material-icons">input</i></a>
</div>

<script src='//static.codepen.io/assets/common/stopExecutionOnTimeout-41c52890748cd7143004e05d3c5f786c66b19939c4500ce446314d1748483e13.js'></script><script src='https://code.jquery.com/jquery-2.1.1.min.js'></script><script src='https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/js/materialize.min.js'></script>
<script>

$(document).ready(function () {
	var selectedVal = "";
	var selected = $("input[type='radio'][name='gender']:checked");
	if (selected.length > 0) {
	    selectedVal = selected.val();
	    
	    console.log(selectedVal);
	}
}
//# sourceURL=pen.js
</script>
</body>

</html>