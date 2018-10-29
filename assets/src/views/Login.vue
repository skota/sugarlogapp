<template>
    <div class="container">
        <div class="column is-4 is-offset-4">
            <h3 class="title has-text-grey">Login</h3>
            <p class="subtitle has-text-grey">Please login to proceed.</p>
            <div class="box">
                <figure class="avatar">
                    <img src="https://placehold.it/50x50">
                </figure>
                <form>
                    <div class="field">
                        <div class="control">
                            <input class="input is-large" type="email" placeholder="Your Email" autofocus="">
                        </div>
                    </div>

                    <div class="field">
                        <div class="control">
                            <input class="input is-large" type="password" placeholder="Your Password">
                        </div>
                    </div>
                    <div class="field">
                        <label class="checkbox">
                            <input type="checkbox">Remember me
                        </label>
                    </div>
                    <button class="button is-block is-info is-large is-fullwidth">Login</button>
                </form>
            </div>
            <p class="has-text-grey">
                <a href="#/register">Sign Up</a> &nbsp;·&nbsp;
                <a href="../">Forgot Password</a> &nbsp;·&nbsp;
                
            </p>
        </div>
    </div>
</template>

