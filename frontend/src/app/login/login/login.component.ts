import { TokenStorageService } from './../../../services/auth/token-storage.service';
import { AuthService } from './../../../services/auth/auth.service';
import { AuthLoginInfo } from './../../forms/loginForm';
import { Token } from './../../Token';
import { LoginService } from './../../../services/login.service';
import { User } from './../../user';
import { Component, OnInit, Input } from '@angular/core';
import { Router } from '@angular/router';
import { NgForm } from '@angular/forms';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ROLE_H, ROLE_SYS, ROLE_A } from 'src/app/globals';
import { allSettled } from 'q';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  idCompany;
  user: User = new User();
  @Input() verified : boolean;
  private loginInfo : AuthLoginInfo;
  isLoggedIn = false;
  isLoginFailed = false;
  errorMessage = '';
  roles: string[] = [];
  token: Token = new Token();

  checkFirst: boolean = false;

  constructor(private authService: AuthService, private router: Router, private tokenStorage: TokenStorageService, private loginService:LoginService) { }

  ngOnInit() {
  }

  home() {
    this.router.navigate(['/home']);
  }
  login() {
    this.loginInfo = new AuthLoginInfo(this.user.email,this.user.password);
    this.authService.attemptAuth(this.loginInfo).subscribe(data => {

     
      if(data.accessToken === undefined) {
        alert("Pokusaj logovanja neverifikovanog korsinika! Potrebno je verifikovati nalog na svom email servisu!")
      } else {
        this.tokenStorage.saveToken(data.accessToken);
        this.tokenStorage.saveUsername(data.username);
        this.tokenStorage.saveAuthorities(data.authorities);
        this.tokenStorage.saveUser(data.user_id);
        this.tokenStorage.saveReserved(0);

        this.isLoginFailed = false;
        this.isLoggedIn = true;
        this.roles = this.tokenStorage.getAuthorities();
        localStorage["sent"] = false;

        this.loginService.getCheckVerify(data.user_id).subscribe(data2 => {
            this.checkFirst = data2;

            if(this.checkFirst) {
              this.loginService.getLoggedByIdCompany(data.user_id).subscribe(data => {
                this.idCompany = data;
                if(this.roles.includes('ROLE_USER')) {
                  this.router.navigate(['/home']);
                } else if(this.roles.includes(ROLE_SYS)) {
                  this.router.navigate(['/admin/profile']);
                } else if(this.roles.includes('ROLE_RENTACARADMIN')) {
                  this.router.navigate(['/rentacar/'+ this.idCompany]);
                } else if(this.roles.includes(ROLE_H)) {
                  this.router.navigate(['/admin/hotel/profile']);
                } else if(this.roles.includes(ROLE_A)) {
                  this.router.navigate(['/home']);
                }
              })
            } else {
              this.router.navigate(['/change-password']);
            }

        })
        

        
        
      
        //alert(this.roles);

        
      }


    },
    error => {
      console.log(error);
      this.isLoginFailed = true;
      
    });
    
  }

    /*his.loginService.login(this.user).subscribe(data => {
      this.token = data;
      localStorage.setItem("jwtToken", this.token.accessToken);
      alert("Sve je ok. User je: " + this.user.firstName + " " + this.user.role)
      if(this.user.role == 3) {
        alert("Ide na home page admina za " + this.user.role);
        this.router.navigate(['/rentacar']);
      } else {
        alert("Ide na home page korisnika!");
      }
      
      console.log(this.user);
    });

    this.user = new User();
  }*/
}
