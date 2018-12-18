<%--
  Created by IntelliJ IDEA.
  User: caiop
  Date: 08/11/2018
  Time: 14:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sair: To-Do</title>

    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <!-- Main CSS -->
    <link rel="stylesheet" href="../css/main.css">
</head>
<body>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="/" title="Dashboard">To-Do</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="/TarefaCtr?action=listTasks" title="Dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="/TarefaCtr?action=lixeira" title="Lixeira">Lixeira</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="/EstadoCtr?action=listStatus" title="Estados">Estados</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger active" href="/UsuarioCtr?action=doLogout" title="Sair">Sair</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<section style="padding-top: 80px">
    <div class="container">
        <div class="row">
            <div class="col-sm-6 offset-3">
                <div class="card">
                    <div class="card-body text-center">
                        <p>Você saiu, em 5 segundos você será redirecionado!</p>
                        <p id="sec"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script type="text/javascript">
    var counter = 6;
    var interval = setInterval(function() {
        counter--;
        document.getElementById("sec").innerText = counter;
        if (counter == 0) {
            clearInterval(interval);
        }
    }, 1000);
    setTimeout(function () {
        window.location.href = "../index.jsp";
    }, 5000);
</script>

</body>
</html>
