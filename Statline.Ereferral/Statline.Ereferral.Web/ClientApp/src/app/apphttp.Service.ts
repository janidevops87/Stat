import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';

import { Router } from '@angular/router';

@Injectable()
export class AppHttpService {
  private headers = new HttpHeaders({ 'Content-Type': 'application/json' });
  constructor(private http: HttpClient, private router: Router) { }

  get(url: string, param: string): Promise<any> {
    return this.http.get(url + param)
      .toPromise()
      .then().catch(error => {
        this.httpStatus(error.status);
        throw error;
      });
  }
  post(url: string, model: any) {
    return this.http.post(url, JSON.stringify(model), { headers: this.headers })
      .toPromise()
      .then().catch(error => {
        this.httpStatus(error.status);
        throw error;
      });
  }
  put(url: string, model: any) {
    return this.http.put(url, JSON.stringify(model), { headers: this.headers })
      .toPromise()
      .then().catch(error => {
        this.httpStatus(error.status);
        throw error;
      });
  }
  delete(url: string, id: string) {
    return this.http.delete(url + '/' + id)
      .toPromise()
      .then(() => null).catch(error => {
        this.httpStatus(error.status);
        throw error;
      });
  }

  httpStatus(status: number) {
    switch (status) {
      case 401: // Unauthorized
        this.router.navigate(['/ContactIiam']);
        break;
      default:
    }
  }
}
