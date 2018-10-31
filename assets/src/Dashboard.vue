<template>
  <div>
    <header class="hero is-light">
        <div class="hero-head">
          <nav class="navbar has-shadow" role="navigation" aria-label="main navigation">
            
            <div class="navbar-brand">
            
              <a class="navbar-item is--brand">
                <img class="navbar-brand-logo" src="/bulma-admin-dashboard-template/logo.png" alt="Bulma Admin Template logo">
              </a>
            <!--  
              <a class="navbar-item is-tab is-hidden-mobile is-active"><span class="icon is-medium"><i class="fa fa-home"></i></span>Home</a>
              <a class="navbar-item is-tab is-hidden-mobile">Features</a>
              <a class="navbar-item is-tab is-hidden-mobile">Pricing</a>
              <a class="navbar-item is-tab is-hidden-mobile">About</a>

              <button class="button navbar-burger" data-target="navMenu">
                <span></span>
                <span></span>
                <span></span>
              </button>
              -->
            </div>
          

            <div class="navbar-menu navbar-end" id="navMenu">

              <!--
              <a class="navbar-item is-tab is-hidden-tablet is-active">Home</a>
              <a class="navbar-item is-tab is-hidden-tablet">Features</a>
              <a class="navbar-item is-tab is-hidden-tablet">Pricing</a>
              <a class="navbar-item is-tab is-hidden-tablet">About</a>
              <a class="navbar-item nav-tag">
                <span class="icon is-small">
                  <i class="fa fa-envelope-o"></i>
                </span>
                <span class="tag is-primary tag-notif">6</span>
              </a>
            -->  
              <div class="navbar-item has-dropdown is-hoverable">
                <a class="navbar-link">
                  <figure class="image is-32x32" style="margin-right:.5em;">
                    <img src="https://avatars1.githubusercontent.com/u/7221389?v=4&s=32">
                  </figure>
                  mazipan
                </a>

                <div class="navbar-dropdown is-right">
                    <a class="navbar-item">
                      <span class="icon is-small">
                        <i class="fa fa-user-o"></i>
                      </span>
                      Profile
                    </a>
                    <hr class="navbar-divider">
                    <a class="navbar-item">
                      <span class="icon is-small">
                        <i class="fa fa-power-off"></i>
                      </span>
                      Logout
                    </a>
                </div>
              </div>
            </div>
          </nav>
        </div>
      </header>

      <div class="wrapper">
        <div class="columns">

          <aside class="column is-2 aside menu">
            <!-- <nav class="menu"> -->
              <p class="menu-label">
                General
              </p>
              <ul class="menu-list has-text-left">

                  <li >  
                    <a href="#/sample1" v-on:click="setActive('readings')" :class="{ active: isActive('readings') }">
                      <span class="icon is-small">
                        <i class="fas fa-pen-fancy"></i>
                      </span>&nbsp;Readings
                    </a>
                  </li>  

                  <li >  
                    <a href="#/sample1" v-on:click="setActive('settings')" :class="{ active: isActive('settings') }">
                      <span class="icon is-small">
                        <i class="fas fa-file-import"></i>
                      </span>&nbsp;Settings
                    </a>
                  </li>  
                  
                  <li >  
                    <a href="#/sample1" v-on:click="setActive('profile')" :class="{ active: isActive('profile') }">
                      <span class="icon is-small">
                        <i class="far fa-user"></i> 
                      </span>&nbsp;Profile
                    </a>
                  </li>  

                    
                  <li>  
                    <a href="#/sample2" v-on:click="setActive('import')" :class="{ active: isActive('import') }">
                      <span class="icon is-small">
                        <i class="fas fa-file-import"></i>
                      </span>&nbsp;Import
                    </a>
                  </li>  
                  
                  <li>  
                    <a href="#/sample3" v-on:click="setActive('export')" :class="{ active: isActive('export') }">
                      <span class="icon is-small">
                        <i class="fas fa-file-export"></i>
                      </span>&nbsp;Export
                    </a>
                  </li>  
                  
                  <li>  
                    <a href="#/sample3" v-on:click="setActive('contact')" :class="{ active: isActive('contact') }">
                      <span class="icon is-small">
                        <i class="fas fa-envelope-open"></i>
                      </span>&nbsp;Contact us
                    </a>
                  </li>  


                  <li>  
                    <a href="#/sample3" v-on:click="setActive('logout')" :class="{ active: isActive('logout') }">
                      <span class="icon is-small">
                        <i class="fas fa-sign-out-alt"></i>
                      </span>&nbsp;Logout
                    </a>
                  </li>  
              </ul>
            <!-- </nav> -->
          </aside>

          <main class="column main">
            <nav class="breadcrumb is-small" aria-label="breadcrumbs">
              <ul>
                <li><a href="#">Home</a></li>
                <li class="is-active"><a href="#" aria-current="page">Dashboard</a></li>
              </ul>
            </nav>

            <div class="level">
              <div class="level-left">
                <div class="level-item">
                  <div class="title has-text-primary"><i class="fas fa-tachometer-alt"></i>&nbsp;Dashboard</div>
                </div>
              </div>
              <div class="level-right">
                <div class="level-item">
                  <button type="button" class="button is-small">
                    March 8, 2017 - April 6, 2017
                  </button>
                </div>
              </div>
            </div>

            <div class="columns is-multiline">
              <div class="column">
                <div class="box notification is-primary">
                  <div class="heading">Top Seller Total</div>
                  <div class="title">56,950</div>
                  <div class="level">
                    <div class="level-item">
                      <div class="">
                        <div class="heading">Sales $</div>
                        <div class="title is-5">250K</div>
                      </div>
                    </div>
                    <div class="level-item">
                      <div class="">
                        <div class="heading">Overall $</div>
                        <div class="title is-5">750K</div>
                      </div>
                    </div>
                    <div class="level-item">
                      <div class="">
                        <div class="heading">Sales %</div>
                        <div class="title is-5">25%</div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="column">
                <div class="box notification is-warning">
                  <div class="heading">Revenue / Expenses</div>
                  <div class="title">55% / 45%</div>
                  <div class="level">
                    <div class="level-item">
                      <div class="">
                        <div class="heading">Rev Prod $</div>
                        <div class="title is-5">30%</div>
                      </div>
                    </div>
                    <div class="level-item">
                      <div class="">
                        <div class="heading">Rev Serv $</div>
                        <div class="title is-5">25%</div>
                      </div>
                    </div>
                    <div class="level-item">
                      <div class="">
                        <div class="heading">Exp %</div>
                        <div class="title is-5">45%</div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="column">
                <div class="box notification is-info">
                  <div class="heading">Feedback Activity</div>
                  <div class="title">78% &uarr;</div>
                  <div class="level">
                    <div class="level-item">
                      <div class="">
                        <div class="heading">Pos</div>
                        <div class="title is-5">1560</div>
                      </div>
                    </div>
                    <div class="level-item">
                      <div class="">
                        <div class="heading">Neg</div>
                        <div class="title is-5">368</div>
                      </div>
                    </div>
                    <div class="level-item">
                      <div class="">
                        <div class="heading">Pos/Neg %</div>
                        <div class="title is-5">77% / 23%</div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="column">
                <div class="box notification is-danger">
                  <div class="heading">Orders / Returns</div>
                  <div class="title">75% / 25%</div>
                  <div class="level">
                    <div class="level-item">
                      <div class="">
                        <div class="heading">Orders $</div>
                        <div class="title is-5">425K</div>
                      </div>
                    </div>
                    <div class="level-item">
                      <div class="">
                        <div class="heading">Returns $</div>
                        <div class="title is-5">106K</div>
                      </div>
                    </div>
                    <div class="level-item">
                      <div class="">
                        <div class="heading">Success %</div>
                        <div class="title is-5">+ 28,5%</div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <router-view></router-view>
          </main>
        </div>
      </div>
  </div>
</template>        

<script>
export default {
  name: 'Dashboard',
  data() {
    return { activeItem: 'readings' }
  },
  methods: {
    isActive: function (menuItem) {
      return this.activeItem === menuItem
    },
    setActive: function (menuItem) {
      this.activeItem = menuItem // no need for Vue.set()
    }
  }
}
</script>

<style>
.hero.is-light {
  background-color: #f5f5f5;
  color: #363636;
}

.nav-tag {
  padding-right: 30px;
}

.tag-notif {
  border-radius: 50%;
  position: absolute;
  top: 5px;
  margin-left: 10px;
}
@media (max-width: 768px) {
  .tag-notif {
    margin-left: -2px;
  }
}

.navbar {
  background: #2E363F;
}
.navbar-item {
  background-color: #2E363F;
  color: #afb8c3 !important;
}
.navbar-item.is-active {
  background-color: #f5f5f5 !important;
  color: #363636 !important;
}
.navbar-item:hover {
  background-color: #f5f5f5 !important;
  color: #363636 !important;
}
.navbar .is--brand:hover {
  background-color: #2E363F !important;
}
.navbar-brand-logo {
  max-height: 3rem !important;
  background-color: #fff;
  border-radius: 0.25em;
  padding: 0.25em;
}
.navbar-dropdown .navbar-item {
  background-color: #fff;
}
.navbar-burger {
  background-color: #2E363F !important;
  border: 0;
}
.navbar-burger span {
  background-color: #00d1b2;
}
.navbar-link figure img {
  border-radius: 50%;
  max-height: 2em;
}

.breadcrumb:not(:last-child) {
  margin-bottom: 0;
}

.aside {
  background: #2E363F;
  padding: 2em 0.2em 0 1em;
}
.aside a {
  color: #afb8c3;
  font-weight: 500;
  /* color: white; */
}

.aside a.hover {
  color: greenyellow;
  /* color: white; */
}
.aside .menu-list li {
  margin-top: 0.5em;
}

.main {
  padding: 2em 1em 0 1em;
}

.menu-label {
  color: #00d1b2;
  margin-left: 0.5em;
}

.block {
  margin-top: 0.5em;
}

.menu-list a.active {
  background-color: #00d1b2;
  color: #fff;
  font-weight: 700;
}

.menu-list a:hover{
  color: black;
  font-weight: 500;
}

#navMenu {
    background-color: #2e363f;
}
</style>