<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <a class="navbar-brand" href="<c:url value="/"/>">Book Store</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <security:authorize access="!hasAnyRole('ADMIN', 'USER')">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="/user/register"/>">Register</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="/login"/>">Login</a>
                    </li>
                </security:authorize>
                <security:authorize access="hasAnyRole('ADMIN', 'USER')">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="/user/userinfo"/>">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="/favorite/all"/>">View Favorites</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value="/cart/view"/>">View Cart</a>
                    </li>
                    <li class="nav-item">
                        <c:url var="logoutUrl" value="/logout"/>
                        <form class="form-inline my-2 my-lg-0" action="${logoutUrl}" method="post">
                            <button class="btn btn-secondary my-2 my-sm-0" type="submit">Log out</button>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        </form>
                    </li>
                </security:authorize>
            </ul>
        </div>
    </div>
</nav>
