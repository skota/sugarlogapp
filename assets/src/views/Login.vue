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
                            <input class="input is-large" 
                            v-model="login.email" 
                            type="email" placeholder="Your Email" 

                            autofocus="" required> 
                        </div>
                        <div v-if="!emailValid" >
                            <p class="help is-danger has-text-weight-semibold"> {{login_errors.email}}</p>
                        </div>
                    </div>

                    <div class="field">
                        <div class="control">
                            <input class="input is-large" 
                                v-model="login.password" 
                                type="password" 
                                placeholder="Your Password" required>
                        </div>
                        <div v-if="!passwordValid" >
                            <p class="help is-danger has-text-weight-semibold"> {{login_errors.password}}</p>
                        </div>
                        <div v-if="login_error" >
                            <p class="help is-danger has-text-weight-semibold"> {{error_message}}</p>
                        </div>
                    </div>
                    <div class="field">
                        <label class="checkbox">
                            <input type="checkbox">Remember me
                        </label>
                    </div>
                    <button class="button is-block is-info is-large is-fullwidth"
                    v-on:click="loginUser">Login</button>
                </form>
            </div>
            <p class="has-text-grey">
                <a href="#/register">Sign Up</a> &nbsp;·&nbsp;
                <a href="../">Forgot Password</a> &nbsp;·&nbsp;
                
            </p>
        </div>
    </div>
</template>


<script>
    import router from '../router';
    import axios from 'axios';

    export default {
        data() {
            return {
                    emailValid: true, //when false show error msg
                    passwordValid: true,
                    error_message: null,
                    login_error: false,
                    
                    login : { 
                        email: "",
                        password: "",
                    },
                    
                    login_errors : { 
                            email:  null,
                            password: null,
                    }
            }
        },
        mounted() {
            //do any init stuff here
        },
    
        methods:{
            
            loginUser() {
                var current = this; //need to do this to be able to access this inside promise
                var config = {
                    headers: {'Content-Type': 'application/json'}
                };

                var new_login = {
                    "login": {
                        "email": this.login.email,
                        "password": this.login.password
                    }
                }

                //TODO: url and port must come from env
                axios.post("http://localhost:4000/api/login", new_login, config)
                .then(function(response) {
                    console.log(response.data) // eslint-disable-line no-console
                    
                    // userid = response.data.userid
                    // jwt = response.data.jwt 
                    // exp = response.data.exp
                    // currentUser = { userid: userid, jwt: jwt, exp: exp}
                    
                    // if (window.localStorage) {
                    //     window.localStorage.setItem('user', null)
                    //     window.localStorage.setItem('token', null)
                    // }
                                    
                    router.push('/secret');
                    
                })
                .catch((error)=> {
                    // console.log(error.response) // eslint-disable-line no-console
                    // console.log(error.response.data.message) // eslint-disable-line no-console
                    current.login_error = true;
                    current.error_message = error.response.data.message;
                })
            },

            //TODO: 
            // setErrorMessage(errors) {
            //     var field = errors[0];
            //     var message = errors[1][0];

            //     switch(field) {
            //         case 'email':
            //             this.emailValid =  false;
            //             this.login_errors.email = message;
            //             break;    
            //         case 'password':
            //             this.passwordValid =  false;
            //             this.login_errors.password = message;
            //             break;    
            //         default:
            //     }
            // }
        }
    } 
</script>
