import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';

import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { ReportModel } from './ReportModel';

@Injectable()
export class AppHttpService {
  private headers = new HttpHeaders({ 'Content-Type': 'application/json' });
  constructor(private http: HttpClient, private router: Router) { }

  get(url: string, param: string): Promise<any> {
    return this.http.get(url + param)
      .toPromise()
      .then().catch(error => {
        this.httpStatus(error.status);
        if (error.url.toLowerCase().indexOf('returnurl') > 0) {
          this.router.navigateByUrl('/?returnurl=' + this.router.url.replace("/",""));
        }
        throw error;
      });
  }

  getRawText(reportModel: ReportModel): Promise<any> {
    return this.http.post("report", JSON.stringify(reportModel), { responseType: "text", headers: this.headers })
      .toPromise()
      .then().catch(error => {
        this.httpStatus(error.status);
        if (error.url.toLowerCase().indexOf('returnurl') > 0) {
          this.router.navigateByUrl('/?returnurl=' + this.router.url.replace("/", ""));
        }
        throw error;
      });
  }


  getFile(reportModel: ReportModel): Observable<Blob>{
    return this.http.post("report", JSON.stringify(reportModel), { responseType: "blob", headers: this.headers });
  }

  post(url: string, model: any) {
    return this.http.post(url, JSON.stringify(model), { headers: this.headers })
      .toPromise()
      .then().catch(error => {
        this.httpStatus(error.status);
        if (error.url.toLowerCase().indexOf('returnurl') > 0) {
          this.router.navigateByUrl('/?returnurl=' + this.router.url.replace("/", ""));
        }
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

  downloadFile(url: string): any {
    return this.http.get(url, { responseType: 'blob' });
  }

  httpStatus(status: number) {
    switch (status) {
      case 401: // Unauthorized
        //this.router.navigate(['/']);
        break;
      default:
    }
  }
}
