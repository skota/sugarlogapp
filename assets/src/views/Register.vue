<template>
    <div class="container">
        <div class="column is-6 is-offset-3">
            <h3 class="title has-text-grey">Register</h3>
            <p class="subtitle has-text-grey">Please create an account.</p>
            <div class="box has-text-left">

                <figure class="avatar">
                    <img src="https://placehold.it/50x50">
                </figure>

                <form>
                    <div class="field">
                        <label class="label">First Name</label>
                        <div class="control">
                            <input class="input is-medium" 
                                    id = "first_name"
                                    v-model="registration.first_name" 
                                    v-on:keydown="validateInput" 
                                    v-on:blur="RequiredFieldsPresent"
                                    type="text" placeholder="john" autofocus=""
                                    maxlength="30">
                        </div>
                        <div v-if="!fnameValid" >
                            <p class="help is-danger has-text-weight-semibold"> {{registration_errors.first_name}}</p>
                        </div>
                    </div>

                    <div class="field">
                        <label class="label">Last Name</label>
                        <div class="control">
                            <input class="input is-medium" 
                            id = "last_name"
                            v-model="registration.last_name" 
                            v-on:keydown="validateInput" 
                            v-on:blur="RequiredFieldsPresent"
                            type="text" placeholder="john" autofocus="" maxlength="30">
                        </div>
                        <div v-if="!lnameValid" >
                            <p class="help is-danger has-text-weight-semibold"> {{registration_errors.last_name}}</p>
                        </div>

                    </div>

                    <div class="field">
                        <label class="label">Email</label>
                        <div class="control">
                            <input class="input is-medium" 
                            id = "email"
                            v-model="registration.email" 
                            v-on:keydown="validateInput" 
                            v-on:blur="RequiredFieldsPresent"
                            type="email" placeholder="Your Email" 
                            autofocus="" 
                            maxlength="40">
                        </div>
                        <div v-if="!emailValid" >
                            <p class="help is-danger has-text-weight-semibold">{{registration_errors.email}}</p>
                        </div> 
                    </div>

                    <div class="field">
                        <label class="label">password</label>
                        <div class="control">
                            <input class="input is-medium" 
                            id = "password"
                            v-model="registration.password" 
                            v-on:keydown="validateInput" 
                            v-on:blur="RequiredFieldsPresent"
                            type="password" placeholder="Your Password"
                            maxlength="10">
                        </div>
                        <div v-if="!passwordValid" >
                            <p class="help is-danger has-text-weight-semibold">
                                {{registration_errors.password}}</p>
                        </div> 
                    </div>

                    <div class="field">
                        <label class="label">Confirm Password</label>
                        <div class="control">
                            <input class="input is-medium" 
                            id = "confirm_password"
                            v-model="registration.confirm_password" 
                            v-on:keydown="validateInput" 
                            v-on:blur="RequiredFieldsPresent"
                            type="password" 
                            placeholder="Your Password"
                            maxlength="10">
                        </div>
                        <div v-if="!confirmPasswordValid" >
                            <p class="help is-danger has-text-weight-semibold">
                                {{registration_errors.confirm_password}}
                            </p>
                        </div>     
                    </div>

                    <div class="field">
                        <label class="checkbox">
                            <input type="checkbox" 
                            v-model="registration.accept_terms"
                            v-on:blur="RequiredFieldsPresent">
                            I accept the terms and conditions
                        </label>
                    </div>

                    <button class="button is-block is-info is-large is-fullwidth"
                    v-on:click="registerUser"
                    id="register-btn" disabled>Signup</button>
                </form>
            </div>
            <p class="has-text-grey">
                <a href="#/login">Have an account</a> &nbsp;·&nbsp;
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
                    fnameValid: true,  //when false show error msg
                    lnameValid: true,  //when false show error msg
                    emailValid: true, //when false show error msg
                    passwordValid: true,
                    confirmPasswordValid: true,
                    requiredFieldsPresent: false, //when this is true set blue background on next button
                    msg: '',
                    registration : { 
                        first_name:null,
                        last_name:null,
                        email: "",
                        password: "",
                        confirm_password: ""
                    }   ,
                    registration_errors : { 
                            first_name: null,
                            last_name:  null,
                            email:  null,
                            password: null,
                            confirm_password: null
                    }
            }
        },
        mounted() {
            //do any init stuff here
        },
    
        methods:{
            validateInput: function(event) {
                var reg =  /^[a-zA-Z]+$/;
                var emailregex = /^([A-Za-z0-9_\-.+])+@([A-Za-z0-9_\-.])+\.([A-Za-z]{2,})$/;
                var passwdRegex = /^(?=.*\d)(?=.*\W)(?=.*[a-z])(?=.*[A-Z]).{8,}$/;

                debugger; // eslint-disable-line
                var srcElem = event.srcElement.id
                switch(srcElem) {
                    case 'first_name':
                        this.fnameValid =  reg.test(event.target.value);
                        if (!this.fnameValid) {
                            this.registration_errors.first_name = "First name can only contain characters";
                        }
                        break;
                    case 'last_name':
                        this.lnameValid =  reg.test(event.target.value);
                        if (!this.lnameValid) { this.registration_errors.last_name = "Last name can only contain characters"; }
                        break;
                    case 'email':
                        this.emaiValid =  emailregex.test(event.target.value);
                        if (!this.emaiValid) { this.registration_errors.email = "Email is invalid"; }
                        break;    
                    case 'password':
                        this.passwordValid =  passwdRegex.test(event.target.value);
                        if ( !this.passwordValid ) { this.registration_errors.password = "Password must be atleast 8 characters long. Must contain atleast 1 capital, 1 special char and 1 number"; }
                        break;    
                    case 'confirm_password':
                        var passwd = document.getElementById("password");
                        this.confirmPasswordValid = ( passwd.val() === event.target.value);
                        if ( !this.confirmPasswordValid ) { 
                            this.registration_errors.confirm_password = "Password must be atleast 8 characters long. Must contain atleast 1 capital, 1 special char and 1 number"; 
                        }

                        break;        
                    default:
                }
            },

            RequiredFieldsPresent: function() {
                var registration = this.registration;
                var reg =  /^[a-zA-Z]+$/;
                var emailregex = /^([A-Za-z0-9_\-.+])+@([A-Za-z0-9_\-.])+\.([A-Za-z]{2,})$/;
                // var passwdRegex = /^(?=.*\d)(?=.*\W)(?=.*[a-z])(?=.*[A-Z]).{8,}$/;

                // debugger; // eslint-disable-line
                if (( ( registration.first_name && registration.first_name.length > 0) &&  
                        reg.test(registration.first_name)) && 
                    ( ( registration.last_name && registration.last_name.length > 0) &&  
                        reg.test(registration.last_name)) &&
                    ( registration.email && registration.email.length > 0) 
                    ) {
                    //enable button   
                    if (!emailregex.test(registration.email)) {
                        this.emailValid =  false
                        return;
                    }

                    // if ( registration.email && registration.email.length >= 8 )

                    var targetElem = document.getElementById("register-btn")
                    targetElem.removeAttribute('disabled');
                    //ok to set button color now
                    this.requiredFieldsPresent = true;
                    this.fnameValid =  true;
                    this.lnameValid = true;
                    this.emailValid =  true;
                }
            },
            registerUser() {
                var current = this; //need to do this to be able to access this inside promise
                var config = {
                    headers: {'Content-Type': 'application/json'}
                };

                var new_signup = {
                    "register": {
                        "first_name": this.registration.first_name,
                        "last_name": this.registration.last_name,
                        "email": this.registration.email,
                        "password": this.registration.password
                    }
                }

                axios.post("http://localhost:4000/api/register", new_signup, config)
                .then(function(response) {
                    console.log(response) // eslint-disable-line no-console
                    router.push('/registered');
                })
                .catch((error)=> {
                    // console.log(error.response) // eslint-disable-line no-console
                    var targetElem = document.getElementById("register-btn")
                    targetElem.setAttribute("disabled","") //disable submit button
                    var errors = Object.entries(error.response.data.errors);
                    current.setErrorMessage(errors[0])
                })
            },

            setErrorMessage(errors) {
                var field = errors[0];
                var message = errors[1][0];

                switch(field) {
                    case 'first_name':
                        this.fnameValid =  false;
                        this.registration_errors.first_name = message;
                        break;
                    case 'last_name':
                        this.lnameValid = false;
                        this.registration_errors.last_name = message;
                        break;
                    case 'email':
                        this.emailValid =  false;
                        this.registration_errors.email = message;
                        break;    
                    case 'password':
                        this.passwordValid =  false;
                        this.registration_errors.password = message;
                        break;    
                    default:
                }
            }
        }
    } 
</script>