<?php

namespace App\Http\Controllers;
use DB;
use Illuminate\Http\Request;
use App\Bridalwear;

class demo extends Controller
{
    public function demo(){
        DB::connection()->enableQueryLog();
        $service_name= request('service_name');
        $location= request('location');
        switch(request('service_name')){
               case 'BridalWear':
                    $service_name = "BridalWear";
                    if (request('cod_bridal') !="*") {
                          $datas = Bridalwear::where('cashondelivery',request('cod_bridal'))->get();
                         // $queries = DB::getQueryLog();
                         // return $last_query = end($queries);
                    }
                    if (request('size_bridal') !="*") {
                        // request('size_bridal');
                        // $query->whereBetween('age', [$ageFrom, $ageTo]);
                            //  $data = Bridalwear::whereBetween('size',[request('size_bridal')])->get();
                            // $queries = DB::getQueryLog();
                            //  return $last_query = end($queries);
                    }
                    $final='';
                    foreach ($datas as $key => $data) {
                      $final = $final.'<div class="venues-slide first">
                                   <div class="img"><img src="'.$data->vendor->profilepicture.'"  alt="" width="450" height="260"></div>
                                   <div class="text">
                                      <h3>'.$data->vendor->ownername.'</h3>
                                      <div class="address">'.$data->vendor->serviceablearea.','.$data->vendor->businesslocation.'</div>
                                      <div class="reviews">
                                         3.5 
                                         <div class="star">
                                            <div class="fill" style="width:70%;"></div>
                                         </div>
                                         reviews
                                      </div>
                                      <div>
                                         <div class="outher-info">
                                            <div class="info-slide first">
                                               <label>Size</label>
                                               <span>'.$data->size.'</span>
                                            </div>
                                            <div class="info-slide">
                                               <label>Shipping</label>
                                               <span>'.$data->shipping.'</span>
                                            </div>
                                            <div class="info-slide">
                                               <label>Cash on Delivery</label>
                                               <span>'.$data->cashondelivery.'</span> 
                                            </div>
                                            <div class="info-slide livedemo">
                                               <label>Live Demo</label>
                                               <span >'.$data->livedemo.'</span>
                                            </div>
                                            <div class="outher-link">
                                               <ul>
                                                  <li><a href="#"><span class="icon icon-calander-check"></span>Check Availability</a></li>
                                                  <li><a href="javascript:;" data-toggle="modal" data-target="#contactModal1"><span class="icon icon-phone"></span>Contact Vendor</a></li>
                                                  <li><a href="#"><span class="icon icon-heart"></span>Add to Wishlist</a></li>
                                                  <li><a href="#"><span class="icon icon-location-1"></span>See on Map</a></li>
                                               </ul>
                                            </div>
                                            <div class="button">
                                               <a href="#" class="btn">Book Now</a>
                                               <a href="javascript:;" class="btn gray">View Details <span class="icon icon-arrow-down"></span></a>
                                            </div>
                                         </div>
                                         <div class="amenities-view">
                                            <h2>All Amenities :</h2>
                                            <div class="amenities-box">
                                               <div class="icon icon-tea"></div>
                                               <span>Coffee Shop</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-wifi"></div>
                                               <span>Wifi</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-parking"></div>
                                               <span>Parking</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-airport-shuttle"></div>
                                               <span>Airport Shuttle</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-bar"></div>
                                               <span>Bar</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-currency-xchg"></div>
                                               <span>Currency Exchange</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-bag"></div>
                                               <span>Business Centre</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-road-guide"></div>
                                               <span>Guide Service</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-yoga"></div>
                                               <span>Yoga Centre</span>
                                            </div>
                                            <div class="amenities-box disabled">
                                               <div class="icon icon-ayurved"></div>
                                               <span>Ayurveda Centre</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-payment"></div>
                                               <span>Payment Mode</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-ac"></div>
                                               <span>A/C</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-handicape"></div>
                                               <span>Handicap Facilities</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-doctor"></div>
                                               <span>Doctor on Call</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-meeting"></div>
                                               <span>Conference Hall</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-apple"></div>
                                               <span>Health Club</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-gym"></div>
                                               <span>Gym</span>
                                            </div>
                                            <div class="amenities-box disabled">
                                               <div class="icon icon-flower"></div>
                                               <span>Florist on Request</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-swimming"></div>
                                               <span>Swimming Pool</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-spoon"></div>
                                               <span>Restaurant</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-massage-center"></div>
                                               <span>Massage Centre</span>
                                            </div>
                                            <div class="amenities-box disabled">
                                               <div class="icon icon-steam-bath"></div>
                                               <span>Steam Sauna</span>
                                            </div>
                                            <div class="amenities-box disabled">
                                               <div class="icon icon-shirt"></div>
                                               <span>Laundry Service</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-spa"></div>
                                               <span>Spa</span>
                                            </div>
                                            <div class="amenities-box disabled">
                                               <div class="icon icon-beauty-saloon"></div>
                                               <span>Beauty Salon</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-sun-bed"></div>
                                               <span>Sun Beds</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-room-service"></div>
                                               <span>Room Service</span>
                                            </div>
                                            <div class="amenities-box">
                                               <div class="icon icon-taxi"></div>
                                               <span>Taxi Service</span>
                                            </div>
                                         </div>
                                         <div class="modal fade modal-vcenter" id="contactModal1" tabindex="-1" role="dialog">
                                            <div class="modal-dialog contactvendor-popup" role="document">
                                               <div class="modal-content">
                                                  <div class="close-icon" aria-label="Close" data-dismiss="modal" ><img src="images/close-icon.png" alt=""></div>
                                                  <h1>Mariom Banquet</h1>
                                                  <div class="note">Lorem Ipsum has been the industry s standard dummy text ever since the 1500s.</div>
                                                  <div class="row">
                                                     <div class="col-sm-6">
                                                        <div class="input-slide">
                                                           <input type="text" placeholder="First Name">
                                                        </div>
                                                     </div>
                                                     <div class="col-sm-6">
                                                        <div class="input-slide">
                                                           <input type="text" placeholder="Last Name ">
                                                        </div>
                                                     </div>
                                                     <div class="col-sm-6">
                                                        <div class="input-slide">
                                                           <input type="text" placeholder="Email ID">
                                                        </div>
                                                     </div>
                                                     <div class="col-sm-6">
                                                        <div class="input-slide">
                                                           <input type="text" placeholder="Phone Number">
                                                        </div>
                                                     </div>
                                                     <div class="col-sm-12">
                                                        <div class="input-slide">
                                                           <textarea placeholder="Message"></textarea>
                                                        </div>
                                                     </div>
                                                     <div class="col-sm-12">
                                                        <div class="submit-slide">
                                                           <input type="submit" value="Send" class="btn">
                                                        </div>
                                                     </div>
                                                  </div>
                                               </div>
                                            </div>
                                         </div>
                                      </div>
                                   </div></div>
                                ';
                    }
                    return $final;

                    // if(request('size_bridal') !="*"){
                    //     $data->where('size',request('size_bridal'));
                    // }else{
                    //     return $data;
                    // }

                    // if(request('size_bridal') !="*"){
                    //     return $data->where('size',request('size_bridal'));
                    // }else{
                    //     return $data;
                    // }


                    // return $datas = Bridalwear::where([$cod])->get();
                    // return $datas = Bridalwear::where(
                    //     if(request('cod_bridal')=='*'){['cashondelivery'=>request('cod_bridal')]})->get();
                break;
          }
    }
}
