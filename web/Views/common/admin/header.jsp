<nav class="navbar navbar-expand-lg " color-on-scroll="500">
    <div class=" container-fluid  ">
        <a class="navbar-brand" href="#pablo"> Dashboard </a>
        <button href class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-bar burger-lines"></span>
            <span class="navbar-toggler-bar burger-lines"></span>
            <span class="navbar-toggler-bar burger-lines"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end mr-5" id="navigation">
            <ul class="nav navbar-nav">
                <li class="nav-item">
                    <a href="#" class="nav-link" data-toggle="dropdown">
                        <span class="d-lg-none">Dashboard</span>
                    </a>
                </li>
                
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="no-icon">Account</span>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/auth?action=logout">
                        <span class="no-icon">Log out</span>
                    </a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>