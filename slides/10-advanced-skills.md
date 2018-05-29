_[Link to Slides](http://www.porganized.com/Scripting-Course/slides/10-advanced-skills.html)_


# Week 10

## Today

- Web scraping
- More on Pandas
- Errata

## Anouncements

- Course evaluations open
- extra office hours: most of Wed and Fri
  - https://organisciak.youcanbook.me/
- MCE Awards: Thursday at 4pm
- Classroom photos
- LIS Potluck
  - June 2nd at 5:30 pm, KRH Commons

## Review: Last Week's Lab

## Review: Questions from the Course

# Python - Running Scripts

1. Save a notebook as a script:
    ![](../images/save-as.png)
2. On the command line: `python name_of_script.py`
    - You may need to navigate to the correct folder with `cd /path/to/folder/name`
    - You may need to activate the Anaconda environment, with either `activate` or `source activate`
    
*Notebooks are good for interaction, `.py` script files are good for repetition*

## Web Scraping

Two parts:
    
1. Get the HTML.

2. Parse the HTML and pull out what you need.

1. Get the HTML with the `urllib` library.
2. Parse with the `BeautifulSoup` library.


```python
import urllib
from bs4 import BeautifulSoup
```

## Getting the data

We won't focus on this too much today, since it's mostly a matter of boilerplate (i.e. consistent, reusable) code.


#1. Create a request.


```python
url = 'http://www.du.edu'
req = urllib.request.Request(url)
```

#2. Use the request to fetch the page.


```python
page = urllib.request.urlopen(req)
```

The results can be read to a string with `page.read()`


```python
content = page.read()
print(content)
```

    b'<!DOCTYPE HTML>\n<html class="no-js" lang="en">\n   <head>\n      <meta charset="UTF-8">\n      <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1, maximum-scale=1">\n      <meta http-equiv="X-UA-Compatible" content="IE=edge">\n      <title>University of Denver</title>\n      <meta property="og:image" content="https://www.du.edu/_duresources/images/avatars/facebook_avatarpreview200x200.jpg">\n      <meta name="twitter:card" content="summary">\n      <meta property="og:site_name" content="University of Denver">\n      <meta name="twitter:image:alt" content="University of Denver shield">\n      <meta name="twitter:site" content="@uofdenver">\n      <meta property="og:title" content="University of Denver">\n      <meta property="og:description" content="">\n      <meta property="og:url" content="https://www.du.edu/">\n<!-- Linked Data - Homepage Only -->\n<script type="application/ld+json">\n\t\t{\n\t\t\t"@context": "http://schema.org",\n\t\t\t"@type": "WebSite",\n\t\t\t"url": "https://www.du.edu/",\n\t\t\t"potentialAction": {\n\t\t\t\t"@type": "SearchAction",\n\t\t\t\t"target": "https://www.du.edu/search.html?q={search_term_string}",\n\t\t\t\t"query-input": "required name=search_term_string"\n\t\t\t},\n\t\t\t"author": {\n\t\t\t\t"@type": "CollegeOrUniversity",\n\t\t\t\t"url": "https://www.du.edu/",\n\t\t\t\t"name": "University of Denver",\n\t\t\t\t"logo": "https://www.du.edu/_duresources/foundation/images/apple-touch-icon.png",\n\t\t\t\t"address": {\n\t\t\t\t\t"@type": "PostalAddress",\n\t\t\t\t\t"addressLocality": "Denver",\n\t\t\t\t\t"addressRegion": "CO",\n\t\t\t\t\t"postalCode": "80208",\n\t\t\t\t\t"streetAddress": "2199 S University Blvd"\n\t\t\t\t},\n\t\t\t\t"telephone": "(303) 871-2000",\n\t\t\t\t"location": {\n\t\t\t\t\t"@type": "Place",\n\t\t\t\t\t"geo": {\n\t\t\t\t\t\t"@type": "GeoCoordinates",\n\t\t\t\t\t\t"latitude": "39.676617",\n\t\t\t\t\t\t"longitude": "-104.961896"\n\t\t\t\t\t}\n\t\t\t\t},\n\t\t\t\t"founder": {\n\t\t\t\t\t"@type": "Person",\n\t\t\t\t\t"name": "John Evans"\n\t\t\t\t},\n\t\t\t\t"foundingDate": {\n\t\t\t\t\t"@type": "Date",\n\t\t\t\t\t"@value": "1864-03-05T00:00:00-06:00"\n\t\t\t\t}\n\t\t\t}\n\t\t}\n</script>\n<meta name="p:domain_verify" content="013556edf2d1ad1f939949f37e000a24" />\n<meta name="google-site-verification" content="FwD01lYHLpYgK46ITYHR7MQOgA9eqcjp-tZt9tHT0dM" />\n<meta name="msvalidate.01" content="734633DF3F913A1A3CEC61CA91D56628" />\n<!-- END Home Page Only -->\n\n<link rel="stylesheet" href="/_duresources/foundation/css/app-home.css" media="all" />\n\n\n<!-- JQUERY -->\n<script src="//code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>\n\n<!-- General DU Meta/Link/tracking -->\n<meta name="author" content="University of Denver" />\n<meta name="Copyright" content="Copyright (c) 2018 University of Denver" />\n<link rel="alternate" href="http://feeds.feedburner.com/DuNewsroom" type="application/rss+xml" title="University of Denver News RSS Feed" />\n<link rel="shortcut icon" href="/favicon.ico" sizes="16x16" type="image/x-icon" />\n<link rel="apple-touch-icon" href="/_duresources/foundation/images/apple-touch-icon.png" />\n<link rel="canonical" hreflang="en-US" href="https://www.du.edu/" />\n<!-- End General DU Meta/Link/tracking -->\n<link rel="stylesheet" href="/_duresources/ou/css/ou-styles.css" />\n<script type="text/javascript" src="//www.du.edu/_duresources/foundation/js/du-analytics.min.js">/*University of Denver*/</script>\n<script type="text/javascript" async="async" src="https://admission.du.edu/ping">/**/</script>\n<script type="text/javascript" async="async" src="https://gradadmissions.du.edu/ping">/**/</script>\n<!--script>\n//<![CDATA[\n(function() {\nvar po = document.createElement(\'script\'); po.type = \'text/javascript\'; po.async = true;\npo.src = \'//api.at.getsocial.io/widget/v1/gs_async.js?id=9e8cac\';\nvar s = document.getElementsByTagName(\'script\')[0]; s.parentNode.insertBefore(po, s);\n})();\n//]]>\n</script--><script src="/_duresources/ou/js/direct-edit.js"></script><meta name="Description" content="We\xe2\x80\x99re a private university dedicated to creating Pioneers who will make a difference. With 14 schools and colleges located in central Denver, we serve over 11,000 graduate and undergraduate students."><script type="text/javascript">\n\t\t\t\t\tvar OUC = OUC || {};\n\t\t\t\t\tOUC.dirname = "/";\n\t\t\t\t\tOUC.filename = "index.html";\n\t\t\t\t\tOUC.path = OUC.dirname + OUC.filename;\n\n\t\t\t\t\tvar page_url="https://www.du.edu/index.html";\n\t\t\t\t</script></head>\n   <body class="du-home">\n      <p class="show-on-focus"><a href="#main-content">Skip to Content</a></p>\n      <div class="off-canvas-wrap"><div aria-label="audience-menu" class="off-canvas position-right" id="audience-menu" data-position="right" data-auto-focus="false" data-transition="push" data-off-canvas="data-off-canvas" onclick="duGA_createEvent(\'Info-For\',\'Open\', \'No Audience\')"><div class="row"><div class="columns small-12 medium-6"><a class="bg-img-btn " title="Current Students" href="/info-for/current-students.html" onclick="duGA_createEvent(\'Info-For\',\'Large Button\',\'Current Students\')"><img src="/_assets/images/core/info-for-buttons/info-for-current-students-button.jpg" alt="Current Students" width="287" height="131"><div class="content"><p>Current Students</p></div></a></div><div class="columns small-12 medium-6"><a class="bg-img-btn " title="Alumni" href="/info-for/alumni.html" onclick="duGA_createEvent(\'Info-For\',\'Large Button\',\'Alumni\')"><img src="/_assets/images/core/info-for-buttons/info-for-alumni-button.jpg" alt="Alumni" width="287" height="131"><div class="content"><p>Alumni</p></div></a></div><div class="columns small-12 medium-6"><a class="bg-img-btn " title="Families" href="/info-for/families.html" onclick="duGA_createEvent(\'Info-For\',\'Large Button\',\'Families\')"><img src="/_assets/images/core/info-for-buttons/info-for-families-button.jpg" alt="Families" width="287" height="131"><div class="content"><p>Families</p></div></a></div><div class="columns small-12 medium-6"><a class="bg-img-btn " title="Neighbors" href="/info-for/neighbors.html" onclick="duGA_createEvent(\'Info-For\',\'Large Button\',\'Neighbors\')"><img src="/_assets/images/core/info-for-buttons/info-for-neighboors-button.jpg" alt="Neighbors" width="287" height="131"><div class="content"><p>Neighbors</p></div></a></div><div class="columns small-12 medium-6"><a class="bg-img-btn " title="Faculty" href="/info-for/faculty.html" onclick="duGA_createEvent(\'Info-For\',\'Large Button\',\'Faculty\')"><img src="/_assets/images/core/info-for-buttons/info-for-faculty-button.jpg" alt="Faculty" width="287" height="131"><div class="content"><p>Faculty</p></div></a></div><div class="columns small-12 medium-6"><a class="bg-img-btn " title="Staff" href="/info-for/staff.html" onclick="duGA_createEvent(\'Info-For\',\'Large Button\',\'Staff\')"><img src="/_assets/images/core/info-for-buttons/info-for-staff-button.jpg" alt="Staff" width="287" height="131"><div class="content"><p>Staff</p></div></a></div></div><div class="row"><div class="columns small-12 medium-6"><a class="btn  btn--dark-red display-block  " role="button " title="Newman Center Box Office" href="http://ev9.evenue.net/cgi-bin/ncommerce3/SEGetGroupList?groupCode=NC&amp;linkID=denver-newman&amp;shopperContext=&amp;caller=&amp;appCode=" target="_blank" onclick="duGA_createEvent(\'Info-For\',\'Small Button\',\'Newman Center\')">\n\t\t\t\tNewman Center\n\t\t\t</a></div><div class="columns small-12 medium-6"><a class="btn  btn--dark-red display-block  " role="button " title="Ritchie Center website" href="http://ritchiecenter.du.edu/" target="_blank" onclick="duGA_createEvent(\'Info-For\',\'Small Button\',\'Ritchie Center\')">\n\t\t\t\tRitchie Center\n\t\t\t</a></div><div class="columns small-12 medium-6"><a class="btn  btn--dark-red display-block  " role="button " title="Cable Center website" href="http://cablecenter.org/" target="_blank" onclick="duGA_createEvent(\'Info-For\',\'Small Button\',\'Cable Center\')">\n\t\t\t\tCable Center\n\t\t\t</a></div><div class="columns small-12 medium-6"><a class="btn  btn--dark-red display-block  " role="button " title="Museum of Anthropology website" href="http://www.du.edu/ahss/anthropology/museum/" target="_blank" onclick="duGA_createEvent(\'Info-For\',\'Small Button\',\'Museum of Anthropology\')">\n\t\t\t\tMuseum of Anthropology\n\t\t\t</a></div><div class="columns small-12 medium-6"><a class="btn  btn--dark-red display-block  " role="button " title="Vicki Myhren Gallery website" href="http://vicki-myhren-gallery.du.edu/" target="_blank" onclick="duGA_createEvent(\'Info-For\',\'Small Button\',\'Vicki Myhren Gallery\')">\n\t\t\t\tVicki Myhren Gallery\n\t\t\t</a></div><div class="columns small-12 medium-6"><a class="btn  btn--dark-red display-block  " role="button " title="Chambers Center website" href="http://womenscollege.du.edu/chambers-center/index.html" target="_blank" onclick="duGA_createEvent(\'Info-For\',\'Small Button\',\'Chambers Center\')">\n\t\t\t\tChambers Center\n\t\t\t</a></div></div></div>         <div class="off-canvas-content" id="off-canvas-content" data-off-canvas-content="data-off-canvas-content">\n            <header role="banner">\n               <div class="hero-media">\n                  <video playsinline="playsinline" muted="true" onloadedmetadata="this.muted = true" loop="true" data-poster="/_assets/images/core/fpo/hero-image.jpg" id="hero-video">\n                     <source src="/_assets/videos/core/homepage/hero_skiing-2018-champs.mp4" type="video/mp4">\n                  </video><img src="/_assets/images/core/fpo/hero-image.jpg" alt="Hero Image"></div>\n               <div class="hero-media__caption" id="hero-media__caption">\n                  <div class="row">\n                     <div class="columns small-12">\n                        <h2><a style="text-decoration: none; color: white;" href="/about/history-traditions.html" onclick="duGA_createEvent(\'Homepage\',\'Hero\', \'We are Denver Pioneers\')">We are the University of Denver. We are Denver Pioneers. &gt;&gt;</a></h2>\n                     </div>\n                  </div>\n               </div>\n               <nav id="utility-menu" class="utility-menu" aria-label="utility-menu">\n                  <ul class="menu align-right">\n\n<li><a href="#" data-toggle="modal_utility_request_info" title="Request Information about the University of Denver" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'request_info-open\')">Request Info</a></li>\n<li><a href="http://www.du.edu/give/index.html" target="_blank" title="Give to the University of Denver" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'give\')">Give</a></li>\n<li><a href="#" data-toggle="modal_utility_visit" title="Find your program representative and schedule a visit" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'visit-open\')">Visit</a></li>\n<li><a href="#" data-toggle="modal_utility_apply" title="Apply to the University of Denver" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-open\')">Apply</a></li>\n\n<!-- Utility CTA Modals -->\n  <!-- REQUEST INFO -->\n  <div class="full reveal" id="modal_utility_request_info" data-reveal="data-reveal" data-animation-in="fade-in" data-animation-out="fade-out">\n    <div class="row align-center modal_wrapper">\n      <div class="columns align-self-middle modal_cta_utility">\n        <div class="row align-center">\n          <div class="columns small-12">\n            <h2 class="btm-divider text-center">Take The <strong>First Step</strong></h2>\n          </div>\n        </div>\n        <div class="row align-center">\n          <div class="columns small-12 medium-4 text-center">\n            <h4>Undergraduates</h4>\n            <p>Contact Undergraduate Admission</p>\n            <p>\n              <a role="button" class="btn" title="Request Info from Undergraduate Admission" href="https://admission.du.edu/register/requestinformation" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'request_info-undergraduate\')">Request Info</a>\n            </p>\n          </div>\n          <div class="columns small-12 medium-4 medium-offset-1 text-center">\n            <h4>Graduates</h4>\n            <p>Request Graduate Program Information</p>\n            <p>\n              <a role="button" class="btn" title="Request Info from Graduate Admission" href="/admission-aid/graduate/request-info.html" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'request_info-graduate\')">Request Info</a>\n            </p>\n          </div>\n        </div>\n      </div>\n    </div>\n    <button class="close-button" data-close aria-label="Close reveal" type="button">\n      <span aria-hidden="true">&times;</span>\n    </button>\n  </div>\n  <!-- VISIT -->\n  <div class="full reveal" id="modal_utility_visit" data-reveal="data-reveal" data-animation-in="fade-in" data-animation-out="fade-out">\n    <div class="row align-center modal_wrapper">\n      <div class="columns align-self-middle modal_cta_utility">\n        <div class="row align-center">\n          <div class="columns small-12">\n            <h2 class="btm-divider text-center">See Our <strong>Campus</strong></h2>\n          </div>\n        </div>\n        <div class="row align-center">\n          <div class="columns small-12 medium-4 text-center">\n            <h4>Undergraduates</h4>\n            <p>View our visit options and schedule your trip to DU.<br/><br/></p>\n            <p>\n              <a role="button" class="btn" title="Schedule your undergraduate visit" href="/admission-aid/undergraduate/visit/index.html" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'visit-undergraduate\')">Schedule a Visit</a>\n            </p>\n          </div>\n          <div class="columns small-12 medium-4 medium-offset-1 text-center">\n            <h4>Graduates</h4>\n            <p>Find your graduate program representative and schedule a visit.</p>\n            <p>\n              <a role="button" class="btn" title="Schedule your graduate visit" href="/admission-aid/graduate/visit-your-program.html" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'visit-graduate\')">Schedule a Visit</a>\n            </p>\n          </div>\n        </div>\n      </div>\n    </div>\n    <button class="close-button" data-close aria-label="Close reveal" type="button">\n      <span aria-hidden="true">&times;</span>\n    </button>\n  </div>\n  <!-- APPLY -->\n  <div class="full reveal" id="modal_utility_apply" data-reveal="data-reveal" data-animation-in="fade-in" data-animation-out="fade-out">\n    <div class="row align-center modal_wrapper">\n      <div class="columns align-self-middle modal_cta_utility">\n        <div class="row align-center">\n          <div class="columns small-12">\n            <h2 class="btm-divider text-center">Start Your <strong>Application</strong></h2>\n          </div>\n        </div>\n        <div class="row">\n          <div class="columns small-12 medium-4">\n            <h5>Undergraduate Applicants</h5>\n          </div>\n          <div class="columns small-12 medium-8">\n            <p>We accept both the Common App and our own Pioneer App. The Common App is a universal application that can be sent to many schools, while the Pioneer App is only used by the University of Denver.</p>\n          </div>\n          <hr style="width:100%"/>\n        </div>\n        <div class="row align-center">\n          <div class="columns small-12 medium-3 text-center">\n            <h6>Pioneer App</h6>\n            <p>\n              <a role="button" class="btn" title="Start a Pioneer App for First Years" href="https://denveradmission.du.edu/web" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-undergraduate-fys_pioneer_app\')">First-Year Students</a>\n              <a role="button" class="btn" title="Start a Pioneer App for Transfer Students" href="https://denveradmission.du.edu/transfer" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-undergraduate-trs_pioneer_app\')">Transfer Students</a>\n            </p>\n          </div>\n          <div class="columns small-12 medium-3 medium-offset-1 text-center">\n            <h6>Common App</h6>\n            <p>\n              <a role="button" class="btn" title="Start a Common App for First Years" href="https://apply.commonapp.org/login?m=78" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-undergraduate-fys_common_app\')">First-Year Students</a>\n              <a role="button" class="btn" title="Start a Common App for Transfer Students" href="https://apply.commonapp.org/login?m=78" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-undergraduate-trs_common_app\')">Transfer Students</a>\n            </p>\n          </div>\n          <div class="columns small-12 medium-3 medium-offset-1 text-center">\n            <h6>Bachelor Completions</h6>\n            <p>\n              <a role="button" class="btn" title="Start an Appliction" href="https://gradadmissions.du.edu/apply/" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-undergraduate-bachelor_completion\')">All Students</a>\n            </p>\n          </div>\n        </div>\n        <div class="row columns"><p>&nbsp;</p></div>\n        <div class="row">\n          <div class="columns small-12 medium-4">\n            <h5>Graduate Applicants</h5>\n          </div>\n          <div class="columns small-12 medium-8">\n            <p>Go to the graduate admission application to submit your information. For information on admission requirements, visit the graduate academic programs page and locate your program of interest.</p>\n          </div>\n          <hr style="width:100%"/>\n        </div>\n        <div class="row align-center">\n          <div class="columns small-12 medium-3 text-center">\n            <h6>Apply Now</h6>\n            <p>\n              <a role="button" class="btn" title="Start a Graduation App" href="https://gradadmissions.du.edu/apply/" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-graduate_app\')">Graduate Application</a>\n            </p>\n          </div>\n          <div class="columns small-12 medium-3 medium-offset-1 text-center">\n            <h6>Explore Programs</h6>\n            <p>\n              <a role="button" class="btn" title="Start a Graduation App" href="/academics/graduate-programs.html" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-graduate_programs\')">Graduate Academic Programs</a>\n            </p>\n          </div>\n          <div class="columns small-12 medium-3 medium-offset-1 text-center">\n            <h6>&nbsp;</h6>\n            <p>&nbsp;</p>\n          </div>\n        </div>\n      </div>\n    </div>\n    <button class="close-button" data-close aria-label="Close reveal" type="button">\n      <span aria-hidden="true">&times;</span>\n    </button>\n  </div>                     <li class="audience-menu"><a href="#audience-menu" data-toggle="audience-menu">Info For</a></li>\n                  </ul>\n               </nav>\n               <div data-sticky-container="data-sticky-container">\n                  <div id="top-bar-sticky-wrap" class="sticky" data-sticky="data-sticky" data-top-anchor="utility-menu:bottom" data-sticky-on="small" data-margin-top="0">\n                     <div class="top-bar">\n                        <nav id="main-menu-wrap">\n                           <div class="row expanded">\n                              <div class="columns shrink">\n\n<a href="/index.html" class="logo" title="University of Denver homepage">\n\t<span>\n\t\t<img src="/_duresources/foundation/images/logo.png" alt="University of Denver Logo" />\n\t\t<img src="/_duresources/foundation/images/logo-text.png" alt="University of Denver Logo Text" />\n\t</span>\n</a>\n</div>\n                              <div class="columns">\n                                 <div id="main-menu"><ul class="vertical large-horizontal menu align-right dropdown" data-options="closeOnClickInside: false;hoverDelay: 300;" data-dropdown-menu="data-dropdown-menu">\n   <li class="mega-menu"><a title="Admission and Aid" href="/admission-aid/index.html">Admission &amp; Aid</a><ul class="menu">\n         <li>\n            <div class="row  mega-menu--alt-layout">\n               <div class="medium-8 columns">\n                  <div class="content-wrap"><img src="/_assets/images/core/fpo/admission-aid-flyout-visit-our-campus.png" alt="The DU campus" width="791" height="391"><div class="content">\n                        <h2>&nbsp;Visit Our Campus</h2>\n                        <p>Discovering our campus is a breeze, whether you\xe2\x80\x99re a high-schooler thinking about\n                           attending DU, an admitted student learning your way around, or a teacher or counselor\n                           setting up a group visit.\n                        </p>\n                        <p><a class="btn" title="link to Campus Visitors page" href="/admission-aid/undergraduate/visit/index.html" role="button">Explore</a></p>\n                     </div>\n                  </div>\n               </div>\n               <div class="medium-4 columns">\n                  <ul>\n                     <li><a title="Admission and Aid Overview" href="/admission-aid/index.html">Admission &amp; Aid Overview</a></li>\n                     <li><a title="Undergraduate Admission" href="/admission-aid/undergraduate/index.html">Undergraduate Admission</a></li>\n                     <li><a title="Graduate Admission" href="/admission-aid/graduate/index.html">Graduate Admission</a></li>\n                     <li><a title="Financial Aid and Scholarships" href="/admission-aid/financial-aid-and-scholarships.html">Financial Aid &amp; Scholarships</a></li>\n                  </ul>\n               </div>\n            </div>\n         </li>\n      </ul>\n   </li>\n   <li class="mega-menu"><a title="Academics" href="/academics/index.html">Academics</a><ul class="menu">\n         <li>\n            <div class="row ">\n               <div class="medium-4 columns">\n                  <div class="content-wrap"><img src="/_assets/images/core/fpo/academics-flyout-outside-the-classroom.png" alt="Students learning outside the classroom" width="388" height="218"><div class="content">\n                        <h2>&nbsp;The World is Your Classroom</h2>\n                        <p>With opportunities to participate in research and internships as well as robust service\n                           learning and study abroad traditions, a DU education takes you beyond the lecture\n                           hall walls.\n                        </p>\n                        <p><a class="btn" title="link to Outside the Classroom page" href="/academics/outside-the-classroom.html" role="button">Explore</a></p>\n                     </div>\n                  </div>\n               </div>\n               <div class="medium-8 columns">\n                  <ul class="two-col">\n                     <li><a title="Academics Overview" href="/academics/index.html">Academics Overview</a></li>\n                     <li><a title="Undergraduate Programs" href="/academics/undergraduate-programs.html">Undergraduate Programs</a></li>\n                     <li><a title="Graduate Programs" href="/academics/graduate-programs.html">Graduate Programs</a></li>\n                     <li><a title="Outside the Classroom" href="/academics/outside-the-classroom.html">Outside the Classroom</a></li>\n                     <li><a title="Study Abroad" href="/academics/study-abroad.html">Study Abroad</a></li>\n                     <li><a title="Libraries" href="/academics/libraries.html">Libraries</a></li>\n                     <li><a title="Schools and Colleges" href="/academics/schools-and-colleges.html">Schools &amp; Colleges</a></li>\n                  </ul>\n               </div>\n            </div>\n         </li>\n      </ul>\n   </li>\n   <li class="mega-menu"><a title="Research Overview" href="/research/index.html">Research</a><ul class="menu">\n         <li>\n            <div class="row ">\n               <div class="medium-4 columns">\n                  <div class="content-wrap"><img src="/_assets/images/core/fpo/research-flyout-what-were-working-on.png" alt="Students conduct research at the University of Denver" width="388" height="218"><div class="content">\n                        <h2>&nbsp;What We\xe2\x80\x99re Working On</h2>\n                        <p>Our student and faculty researchers are blazing trails, and the world is taking notice.\n                           Check out some of our recent success stories and our ongoing efforts to improve our\n                           world.\n                        </p>\n                        <p><a class="btn" title="link to In the News page" href="/research/in-news.html" role="button">Explore</a></p>\n                     </div>\n                  </div>\n               </div>\n               <div class="medium-8 columns">\n                  <ul class="two-col">\n                     <li><a title="Research Overview" href="/research/index.html">Research Overview</a></li>\n                     <li><a title="Centers and Institutes" href="/research/centers-institutes.html">Centers &amp; Institutes</a></li>\n                     <li><a title="Health and Wellness" href="/research/health-wellness.html">Health &amp; Wellness</a></li>\n                     <li><a title="Society and Culture" href="/research/society-culture.html">Society &amp; Culture</a></li>\n                     <li><a title="Technology and Science" href="/research/technology-science.html">Technology &amp; Science</a></li>\n                     <li><a title="In the News" href="/research/in-news.html">In the News</a></li>\n                     <li><a title="About DU Research" href="/research/about.html">About DU Research</a></li>\n                  </ul>\n               </div>\n            </div>\n         </li>\n      </ul>\n   </li>\n   <li class="mega-menu"><a title="Campus Life Overview" href="/campus-life/index.html">Campus Life</a><ul class="menu">\n         <li>\n            <div class="row  mega-menu--alt-layout">\n               <div class="medium-8 columns">\n                  <div class="content-wrap"><img src="/_assets/images/core/fpo/campus-life-flyout-make-yourself-at-home.png" alt="DU students make campus their home" width="791" height="391"><div class="content">\n                        <h2>&nbsp;Make Yourself at Home</h2>\n                        <p>With well-appointed, sustainable residence halls and meals made from scratch to accommodate\n                           all dietary needs, DU is a place you can feel at home.\n                        </p>\n                        <p><a class="btn" title="link to Housing and Dining page" href="/campus-life/living-at-du/housing-dining.html" role="button">Explore</a></p>\n                     </div>\n                  </div>\n               </div>\n               <div class="medium-4 columns">\n                  <ul>\n                     <li><a title="Campus Life Overview" href="/campus-life/index.html">Campus Life Overview</a></li>\n                     <li><a title="Living at DU" href="/campus-life/living-at-du/index.html">Living at DU</a></li>\n                     <li><a title="Arts and Activities" href="/campus-life/arts-activities.html">Arts &amp; Activities</a></li>\n                     <li><a title="Academic Support" href="/campus-life/academic-support.html">Academic Support</a></li>\n                  </ul>\n               </div>\n            </div>\n         </li>\n      </ul>\n   </li>\n   <li><a title="Athletics page" href="/athletics/index.html">Athletics</a></li>\n   <li><a title="News" href="/news/index.html">News</a></li>\n   <li class="mega-menu"><a title="About" href="/about/index.html">About</a><ul class="menu">\n         <li>\n            <div class="row ">\n               <div class="medium-4 columns">\n                  <div class="content-wrap"><img src="/_assets/images/core/6-0_about/impact-menu-story-image.jpg" alt="DU Impact 2025" width="388" height="218"><div class="content">\n                        <h2>&nbsp;The Genius is in the Doing</h2>\n                        <p>We are two years into our 10-year strategic plan. Learn about our vision for DU students\n                           and the community.\n                        </p>\n                        <p><a class="btn" title="link to DU Impact 2025 website" href="http://impact.du.edu/" role="button">Explore</a></p>\n                     </div>\n                  </div>\n               </div>\n               <div class="medium-8 columns">\n                  <ul class="two-col">\n                     <li><a title="About Overview" href="/about/index.html">About Overview</a></li>\n                     <li><a title="Educational Approach" href="/about/educational-approach.html">Educational Approach</a></li>\n                     <li><a title="Local Involvement" href="/about/local-involvement/index.html">Local Involvement</a></li>\n                     <li><a title="Global Reach" href="/about/global-reach.html">Global Reach</a></li>\n                     <li><a title="History + Traditions" href="/about/history-traditions.html">History &amp; Traditions</a></li>\n                     <li><a title="Alumni" href="/about/alumni.html">Alumni</a></li>\n                     <li><a title="Our Leadership" href="/about/our-leadership/index.html">Our Leadership</a></li>\n                  </ul>\n               </div>\n            </div>\n         </li>\n      </ul>\n   </li>\n   <li><a class="calendar-icon-nav" title="Calendar" href="/calendar/index.html">Events</a></li>\n</ul>                                    <nav class="utility-menu show-for-small-only" aria-label="utility-menu">\n                                       <ul class="menu align-right">\n\n<li><a href="#" data-toggle="modal_utility_request_info" title="Request Information about the University of Denver" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'request_info-open\')">Request Info</a></li>\n<li><a href="http://www.du.edu/give/index.html" target="_blank" title="Give to the University of Denver" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'give\')">Give</a></li>\n<li><a href="#" data-toggle="modal_utility_visit" title="Find your program representative and schedule a visit" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'visit-open\')">Visit</a></li>\n<li><a href="#" data-toggle="modal_utility_apply" title="Apply to the University of Denver" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-open\')">Apply</a></li>\n\n<!-- Utility CTA Modals -->\n  <!-- REQUEST INFO -->\n  <div class="full reveal" id="modal_utility_request_info" data-reveal="data-reveal" data-animation-in="fade-in" data-animation-out="fade-out">\n    <div class="row align-center modal_wrapper">\n      <div class="columns align-self-middle modal_cta_utility">\n        <div class="row align-center">\n          <div class="columns small-12">\n            <h2 class="btm-divider text-center">Take The <strong>First Step</strong></h2>\n          </div>\n        </div>\n        <div class="row align-center">\n          <div class="columns small-12 medium-4 text-center">\n            <h4>Undergraduates</h4>\n            <p>Contact Undergraduate Admission</p>\n            <p>\n              <a role="button" class="btn" title="Request Info from Undergraduate Admission" href="https://admission.du.edu/register/requestinformation" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'request_info-undergraduate\')">Request Info</a>\n            </p>\n          </div>\n          <div class="columns small-12 medium-4 medium-offset-1 text-center">\n            <h4>Graduates</h4>\n            <p>Request Graduate Program Information</p>\n            <p>\n              <a role="button" class="btn" title="Request Info from Graduate Admission" href="/admission-aid/graduate/request-info.html" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'request_info-graduate\')">Request Info</a>\n            </p>\n          </div>\n        </div>\n      </div>\n    </div>\n    <button class="close-button" data-close aria-label="Close reveal" type="button">\n      <span aria-hidden="true">&times;</span>\n    </button>\n  </div>\n  <!-- VISIT -->\n  <div class="full reveal" id="modal_utility_visit" data-reveal="data-reveal" data-animation-in="fade-in" data-animation-out="fade-out">\n    <div class="row align-center modal_wrapper">\n      <div class="columns align-self-middle modal_cta_utility">\n        <div class="row align-center">\n          <div class="columns small-12">\n            <h2 class="btm-divider text-center">See Our <strong>Campus</strong></h2>\n          </div>\n        </div>\n        <div class="row align-center">\n          <div class="columns small-12 medium-4 text-center">\n            <h4>Undergraduates</h4>\n            <p>View our visit options and schedule your trip to DU.<br/><br/></p>\n            <p>\n              <a role="button" class="btn" title="Schedule your undergraduate visit" href="/admission-aid/undergraduate/visit/index.html" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'visit-undergraduate\')">Schedule a Visit</a>\n            </p>\n          </div>\n          <div class="columns small-12 medium-4 medium-offset-1 text-center">\n            <h4>Graduates</h4>\n            <p>Find your graduate program representative and schedule a visit.</p>\n            <p>\n              <a role="button" class="btn" title="Schedule your graduate visit" href="/admission-aid/graduate/visit-your-program.html" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'visit-graduate\')">Schedule a Visit</a>\n            </p>\n          </div>\n        </div>\n      </div>\n    </div>\n    <button class="close-button" data-close aria-label="Close reveal" type="button">\n      <span aria-hidden="true">&times;</span>\n    </button>\n  </div>\n  <!-- APPLY -->\n  <div class="full reveal" id="modal_utility_apply" data-reveal="data-reveal" data-animation-in="fade-in" data-animation-out="fade-out">\n    <div class="row align-center modal_wrapper">\n      <div class="columns align-self-middle modal_cta_utility">\n        <div class="row align-center">\n          <div class="columns small-12">\n            <h2 class="btm-divider text-center">Start Your <strong>Application</strong></h2>\n          </div>\n        </div>\n        <div class="row">\n          <div class="columns small-12 medium-4">\n            <h5>Undergraduate Applicants</h5>\n          </div>\n          <div class="columns small-12 medium-8">\n            <p>We accept both the Common App and our own Pioneer App. The Common App is a universal application that can be sent to many schools, while the Pioneer App is only used by the University of Denver.</p>\n          </div>\n          <hr style="width:100%"/>\n        </div>\n        <div class="row align-center">\n          <div class="columns small-12 medium-3 text-center">\n            <h6>Pioneer App</h6>\n            <p>\n              <a role="button" class="btn" title="Start a Pioneer App for First Years" href="https://denveradmission.du.edu/web" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-undergraduate-fys_pioneer_app\')">First-Year Students</a>\n              <a role="button" class="btn" title="Start a Pioneer App for Transfer Students" href="https://denveradmission.du.edu/transfer" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-undergraduate-trs_pioneer_app\')">Transfer Students</a>\n            </p>\n          </div>\n          <div class="columns small-12 medium-3 medium-offset-1 text-center">\n            <h6>Common App</h6>\n            <p>\n              <a role="button" class="btn" title="Start a Common App for First Years" href="https://apply.commonapp.org/login?m=78" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-undergraduate-fys_common_app\')">First-Year Students</a>\n              <a role="button" class="btn" title="Start a Common App for Transfer Students" href="https://apply.commonapp.org/login?m=78" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-undergraduate-trs_common_app\')">Transfer Students</a>\n            </p>\n          </div>\n          <div class="columns small-12 medium-3 medium-offset-1 text-center">\n            <h6>Bachelor Completions</h6>\n            <p>\n              <a role="button" class="btn" title="Start an Appliction" href="https://gradadmissions.du.edu/apply/" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-undergraduate-bachelor_completion\')">All Students</a>\n            </p>\n          </div>\n        </div>\n        <div class="row columns"><p>&nbsp;</p></div>\n        <div class="row">\n          <div class="columns small-12 medium-4">\n            <h5>Graduate Applicants</h5>\n          </div>\n          <div class="columns small-12 medium-8">\n            <p>Go to the graduate admission application to submit your information. For information on admission requirements, visit the graduate academic programs page and locate your program of interest.</p>\n          </div>\n          <hr style="width:100%"/>\n        </div>\n        <div class="row align-center">\n          <div class="columns small-12 medium-3 text-center">\n            <h6>Apply Now</h6>\n            <p>\n              <a role="button" class="btn" title="Start a Graduation App" href="https://gradadmissions.du.edu/apply/" target="_blank" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-graduate_app\')">Graduate Application</a>\n            </p>\n          </div>\n          <div class="columns small-12 medium-3 medium-offset-1 text-center">\n            <h6>Explore Programs</h6>\n            <p>\n              <a role="button" class="btn" title="Start a Graduation App" href="/academics/graduate-programs.html" onclick="duGA_createEvent(\'CTA\',\'utility-menu\',\'apply-graduate_programs\')">Graduate Academic Programs</a>\n            </p>\n          </div>\n          <div class="columns small-12 medium-3 medium-offset-1 text-center">\n            <h6>&nbsp;</h6>\n            <p>&nbsp;</p>\n          </div>\n        </div>\n      </div>\n    </div>\n    <button class="close-button" data-close aria-label="Close reveal" type="button">\n      <span aria-hidden="true">&times;</span>\n    </button>\n  </div></ul>\n                                    </nav>\n                                 </div>\n                              </div>\n<div class="columns shrink hide-for-large">\n    <a href="/calendar/index.html" id="calendar-icon"></a>\n</div>                              <div class="columns shrink">\n                                 <ul id="search-toggler" class="dropdown menu" data-dropdown-menu="data-dropdown-menu" data-options="clickOpen: true; closeOnClickInside: false; closeOnClick:true; disableHover: true;">\n                                    <li class="search mega-menu"><a href="#">Search</a><ul id="search" class="menu">\n                                          <li>\n                                             <div class="row">\n                                                <div class="columns">\n                                                   <form name="gbl-search" action="/search.html" method="get" class="search-box"><label class="show-for-sr" for="search-input" aria-label="search-label">Search Input</label><input name="q" id="search-input" placeholder="Search" type="text" autofocus><button type="button"><span class="du-icon-cust-search" aria-hidden="true"></span><span class="show-for-sr">Submit Search</span></button></form>\n                                                </div>\n                                             </div>\n                                          </li>\n                                       </ul>\n                                    </li>\n                                 </ul>\n                                 <div id="main-menu-toggler" class="align-right" data-responsive-toggle="main-menu" data-hide-for="large"><button class="du-icon-cust-menu" type="button" data-toggle="main-menu"><span class="show-for-sr">Toggle Menu</span></button></div>\n                              </div>\n                           </div>\n                        </nav>\n                     </div>\n                  </div>\n               </div>\n            </header>\n            <article id="main-content">\n               <h1 class="show-for-sr">University of Denver</h1>\n               <!--BEGIN Section Copy-->\n               <div class="row du-home__section-1">\n                  <div class="columns small-12">\n                     <h2 class="btm-divider text-center">A <strong>Foundation</strong> of Learning\n                     </h2>\n                  </div>\n                  <div class="columns small-12 order-1 medium-order-2 medium-8 large-7">\n                     \n                     <p>As a private university located near the Rocky Mountains, we empower students who\n                        want to make a difference. Based in south Denver and with over 300 academic programs,\n                        we serve about 12,000 graduate and undergraduate students. Our classroom academics,\n                        hands-on educational experiences and global learning adventures put students on the\n                        path toward lives and careers that will shape the world.\n                     </p>\n                     \n                  </div>\n                  <div class="columns small-12 order-2 medium-order-1 medium-4">\n                     <ul class="list-of-links--alt">\n                        <li><a href="/academics/index.html" onclick="duGA_createEvent(\'Homepage\',\'Inline CTA\', \'1 - DU academics\')">Explore DU Academics</a><br><br> <a href="http://report.du.edu/" onclick="duGA_createEvent(\'Homepage\',\'Inline CTA\', \'1 - DU academics\')">Chancellor\'s Report 2017</a></li>\n                     </ul>\n                  </div>\n               </div>\n               <!--END Section Copy-->\n               \n               <p>&nbsp;</p>\n               <!--BEGIN Wide Carousel-->\n               <div class="wide-carousel__wrapper row">\n                  <div class="columns small-12 medium-offset-7 medium-5">\n                     \n                     <h3 class="top-divider"><strong>Classes</strong> Create<br> Your Blueprint\n                     </h3>\n                     \n                  </div>\n                  <div class="wide-carousel columns small-12">\n                     <div id="wide-carousel-id" class="orbit" role="region" aria-label="Favorite Space Pictures" data-orbit="data-orbit" data-auto-play="true" data-use-m-u-i="false" data-timer-delay="10000" data-pause-on-hover="false">\n                        <div class="orbit-container">\n                           <div class="orbit-slide is-active">\n                              <div class="row expanded">\n                                 <div class="columns order-1 medium-order-2 small-12">\n                                    <div class="wide-carousel__media-wrapper">\n                                       <video poster="" muted="true" onloadedmetadata="this.muted = true">\n                                          <source src="/_assets/videos/core/homepage/In-Class-v2.mp4" type="video/mp4">\n                                       </video><img src="/_assets/images/core/0-0_homepage/mobile-1-classroom.jpg" alt="classroom shot" class="orbit-image"></div>\n                                 </div>\n                                 <div class="columns order-2 medium-order-1 small-12 wide-carousel__content medium-6 medium-offset-1">\n                                    \n                                    <p><strong>Tell us your passion\xe2\x80\x94</strong>we\'ll find a program to help you build your future. Start&nbsp;with our liberal arts program,\n                                       and gain&nbsp;the broad view, then&nbsp;blend formal degree programs with professional education\n                                       to launch an inspiring career.\n                                    </p>\n                                    \n                                 </div>\n                              </div>\n                           </div>\n                           <div class="orbit-slide">\n                              <div class="row expanded">\n                                 <div class="columns order-1 medium-order-2 small-12">\n                                    <div class="wide-carousel__media-wrapper">\n                                       <video poster="" muted="true" onloadedmetadata="this.muted = true">\n                                          <source src="/_assets/videos/core/home-wc-vehicle.mp4" type="video/mp4">\n                                       </video><img src="/_assets/images/core/0-0_homepage/mobile-1-vehicle.jpg" alt="unmanned vehicle" class="orbit-image"></div>\n                                 </div>\n                                 <div class="columns order-2 medium-order-1 small-12 wide-carousel__content medium-6 medium-offset-1">\n                                    \n                                    <p><strong>Discovery and research form the backbone of the DU experience.</strong> Our students create technologies, solve social challenges and advance how we think\n                                       about international relations, to name a few of the projects our undergraduate and\n                                       graduate students have tackled.\n                                    </p>\n                                    \n                                 </div>\n                              </div>\n                           </div>\n                        </div>\n                        <nav class="orbit-bullets show-for-small-only"><button data-slide="0" class="is-active"><span class="show-for-sr">\n                                 \n                                 <p><strong>Tell us your passion\xe2\x80\x94</strong>we\'ll find a program to help you build your future. Start&nbsp;with our liberal arts program,\n                                    and gain&nbsp;the broad view, then&nbsp;blend formal degree programs with professional education\n                                    to launch an inspiring career.\n                                 </p>\n                                 </span></button><button data-slide="1"><span class="show-for-sr">\n                                 \n                                 <p><strong>Discovery and research form the backbone of the DU experience.</strong> Our students create technologies, solve social challenges and advance how we think\n                                    about international relations, to name a few of the projects our undergraduate and\n                                    graduate students have tackled.\n                                 </p>\n                                 </span></button></nav>\n                     </div>\n                  </div>\n               </div>\n               <!--END Wide Carousel-->\n               \n               <p>&nbsp;</p>\n               <!--BEGIN Swapping Image Feature-->\n               <div class="row">\n                  <div class="columns small-12 medium-4  medium-offset-1">\n                     \n                     <h3 class="top-divider text-right"><strong>Experience</strong> Is Our Training Ground\n                     </h3>\n                     \n                  </div>\n               </div>\n               <div class="row row--expanded swapping-img-feature">\n                  <div class="columns small-12 medium-6 swapping-img-feature__image"><img src="/_assets/images/core/fpo/home-ed-02_tinyhouse.jpg" alt="alt text" width="592" height="397" data-img-0="/_assets/images/core/fpo/home-ed-02_tinyhouse.jpg" data-img-1="/_assets/images/core/0-0_homepage/grad-student-hiking.jpg"></div>\n                  <div class="columns small-12 medium-6">\n                     <div class="swapping-img-feature__content">\n                        \n                        <p>A DU education takes you out of the classroom and into communities where you can learn\n                           by making an impact. Our academic programs incorporate real-world learning, connecting\n                           you with the professional environments you\xe2\x80\x99ll strive toward after graduation.\n                        </p>\n                        \n                        <p>We\xe2\x80\x99re a student-centered research university, developing knowledge to tackle challenges\n                           worldwide. Whether you\xe2\x80\x99re researching Alzheimer\xe2\x80\x99s, sustainable technologies or the\n                           needs of underserved communities, you\xe2\x80\x99ll have the resources and support to make your\n                           discoveries at home and abroad.\n                        </p>\n                        \n                        <ul class="list-of-links--alt">\n                           <li><a title="Outside the Classroom" href="/academics/outside-the-classroom.html" onclick="duGA_createEvent(\'Homepage\',\'Inline CTA\', \'2 - Outside the Classroom\')">Outside the Classroom</a></li>\n                        </ul>\n                     </div>\n                  </div>\n               </div>\n               <!--END Swapping Image Feature-->\n               \n               <p>&nbsp;</p>\n               <!--BEGIN Three Column Facts-->\n               <div class="row">\n                  <div class="columns small-12 medium-5 medium-offset-7">\n                     \n                     <h3 class="top-divider">The <strong>World</strong> Is Your Inspiration\n                     </h3>\n                     \n                  </div>\n               </div>\n               <div id="threeColFacts" class="row three-col-facts" style="background-image: url(\'/_assets/images/core/fpo/home-3-col-facts-img.png\');">\n                  <div class="columns small-12 show-for-small-only">\n                     <div data-sticky-container="data-sticky-container">\n                        <div class="three-col-facts__img sticky" data-sticky="data-sticky" data-margin-top="4" data-margin-bottom="0" data-anchor="threeColFacts" data-sticky-on="small"><img src="/_assets/images/core/fpo/home-3-col-facts-img.png" alt="quick facts" width="1123" height="559"></div>\n                     </div>\n                  </div>\n                  <div class="columns small-12 medium-4 three-col-facts__item">\n                     \n                     <p><strong>71%</strong> of our undergrads<br>study abroad\n                     </p>\n                     \n                  </div>\n                  <div class="columns small-12 medium-4 three-col-facts__item">\n                     \n                     <p><strong>1400</strong> students from outside the US\n                     </p>\n                     \n                  </div>\n                  <div class="columns small-12 medium-4 three-col-facts__item">\n                     \n                     <p><strong>145</strong> countries are home to alumni\n                     </p>\n                     \n                  </div>\n               </div>\n               <!--END Three Column Facts-->\n               \n               <p>&nbsp;</p>\n               <!--BEGIN Quotes Module-->\n               <div class="quotes-module__wrapper">\n                  <div class="row row--expanded quotes-module">\n                     <div class="columns small-12">\n                        <div class="orbit" role="region" aria-label="Favorite Space Pictures" data-orbit="data-orbit" data-auto-play="false">\n                           <div class="orbit-container">\n                              <div class="is-active orbit-slide">\n                                 <div class="row">\n                                    <div class="columns small-12 medium-9">\n                                       <div class="quotes-module__content">\n                                          <blockquote>\n                                             \n                                             <p>I love DU. It\xe2\x80\x99s big enough that I could discover so many new things but small enough\n                                                that I don\xe2\x80\x99t feel like a face in the crowd.\n                                             </p>\n                                             <cite>Zane Sanchez <small>dual degree in Accountancy, Class of \'16</small></cite></blockquote>\n                                       </div>\n                                    </div>\n                                    <div class="columns small-12 medium-3 hide-for-small-only">\n                                       <div class="quotes-module__image"><img src="/_assets/images/core/homepage/q1-zane-s.png" alt="Zane Sanchez" width="501" height="493"></div>\n                                    </div>\n                                 </div>\n                              </div>\n                              <div class="orbit-slide">\n                                 <div class="row">\n                                    <div class="columns small-12 medium-9">\n                                       <div class="quotes-module__content">\n                                          <blockquote>\n                                             \n                                             <p>I feel like the community has empowered me and given me the confidence in myself and\n                                                in my peers to make huge changes that I don\'t think I would have thought I was capable\n                                                of without DU.\n                                             </p>\n                                             <cite>Emily Wolverton <small>Biology major, Class of \'17</small></cite></blockquote>\n                                       </div>\n                                    </div>\n                                    <div class="columns small-12 medium-3 hide-for-small-only">\n                                       <div class="quotes-module__image"><img src="/_assets/images/core/homepage/q3-emily-w.png" alt="Emily Wolverton" width="501" height="493"></div>\n                                    </div>\n                                 </div>\n                              </div>\n                              <div class="orbit-slide">\n                                 <div class="row">\n                                    <div class="columns small-12 medium-9">\n                                       <div class="quotes-module__content">\n                                          <blockquote>\n                                             \n                                             <p>I got to study abroad in Ghana, which expanded my views and made me more globally\n                                                minded. I realized how influential I could be around the world.\n                                             </p>\n                                             <cite>Cameron Simmons <small>Class of \'16, Black Student Alliance president</small></cite></blockquote>\n                                       </div>\n                                    </div>\n                                    <div class="columns small-12 medium-3 hide-for-small-only">\n                                       <div class="quotes-module__image"><img class="" src="/_assets/images/core/homepage/q2-cameron-s.png" alt="Cameron Simmons" width="501" height="493"></div>\n                                    </div>\n                                 </div>\n                              </div>\n                           </div>\n                           <nav class="orbit-bullets"><button data-slide="0" class="is-active"><span class="show-for-sr">\n                                    \n                                    <p>I love DU. It\xe2\x80\x99s big enough that I could discover so many new things but small enough\n                                       that I don\xe2\x80\x99t feel like a face in the crowd.\n                                    </p>\n                                    </span></button> <button data-slide="1"><span class="show-for-sr">\n                                    \n                                    <p>I feel like the community has empowered me and given me the confidence in myself and\n                                       in my peers to make huge changes that I don\'t think I would have thought I was capable\n                                       of without DU.\n                                    </p>\n                                    </span></button> <button data-slide="2"><span class="show-for-sr">\n                                    \n                                    <p>I got to study abroad in Ghana, which expanded my views and made me more globally\n                                       minded. I realized how influential I could be around the world.\n                                    </p>\n                                    </span></button> \n                           </nav>\n                        </div>\n                     </div>\n                  </div>\n               </div>\n               <!--END Quotes Module-->\n               <!--BEGIN Swapping Image Feature: Alt Layout-->\n               <div class="row">\n                  <div class="columns small-12">\n                     \n                     <h2 class="btm-divider text-right text-center">Forging the Future <strong>Together</strong></h2>\n                     \n                  </div>\n               </div>\n               <div class="row row--expanded swapping-img-feature swapping-img-feature--alt">\n                  <div class="columns small-12 medium-6">\n                     <div class="swapping-img-feature__content">\n                        \n                        <p>It\xe2\x80\x99s about finding your place, and we have a niche for almost everyone. Our students\n                           find rewards in opportunities and lifelong relationships, in exploring new interests\n                           and building projects from the ground up. From joining a club and improving local\n                           communities to exploring Colorado\xe2\x80\x99s natural landscape, your experiences will shape\n                           your future.\n                        </p>\n                        \n                        <ul class="list-of-links--alt">\n                           <li><a title="The DU Community" href="/about/local-involvement/index.html" onclick="duGA_createEvent(\'Homepage\',\'Inline CTA\', \'3 - The DU Community\')">The DU Community</a></li>\n                        </ul>\n                     </div>\n                  </div>\n                  <div class="columns small-12 medium-6 swapping-img-feature__image"><img class="" src="/_assets/images/core/0-0_homepage/grad-students-talking.jpg" alt="Graduate Students Talking" width="687" height="460" data-img-0="/_assets/images/core/0-0_homepage/grad-students-talking.jpg" data-img-1="/_assets/images/core/fpo/home-com-02_classoutside.jpg" data-img-2="/_assets/images/core/fpo/home-com-03_watchparty.jpg"></div>\n               </div>\n               <!--END Swapping Image Feature: Alt Layout-->\n               \n               <p>&nbsp;</p>\n               <!--BEGIN Wide Carousel: Alt Layout-->\n               <div class="wide-carousel__wrapper row wide-carousel__wrapper--alt">\n                  <div class="columns small-12 medium-5">\n                     \n                     <h3 class="top-divider text-right">A Community of <strong>Doers</strong></h3>\n                     \n                  </div>\n                  <div class="wide-carousel columns small-12">\n                     <div id="wide-carousel-id2" class="orbit" role="region" aria-label="Favorite Space Pictures" data-orbit="data-orbit" data-auto-play="true" data-use-m-u-i="false" data-timer-delay="10000" data-pause-on-hover="false">\n                        <div class="orbit-container">\n                           <div class="orbit-slide is-active">\n                              <div class="row expanded">\n                                 <div class="columns order-1 medium-order-2 small-12">\n                                    <div class="wide-carousel__media-wrapper">\n                                       <video poster="" muted="true" onloadedmetadata="this.muted = true">\n                                          <source src="/_assets/videos/core/homepage/wide-carousel-01-campus-community.mp4" type="video/mp4">\n                                       </video><img src="/_assets/images/core/0-0_homepage/mobile-2-campus.jpg" alt="campus" class="orbit-image"></div>\n                                 </div>\n                                 <div class="columns order-2 medium-order-1 small-12 wide-carousel__content medium-6 medium-offset-5">\n                                    \n                                    <p><strong>Our campus is built to inspire.</strong> Nestled in the Denver metro area, our 125 acres are minutes from downtown and a stone\xe2\x80\x99s\n                                       throw from the Rocky Mountains. With 300 days of sunshine and beautiful sights in\n                                       the middle of winter, this is a place you\'ll be excited to call your home.\n                                    </p>\n                                    \n                                 </div>\n                              </div>\n                           </div>\n                           <div class="orbit-slide">\n                              <div class="row expanded">\n                                 <div class="columns order-1 medium-order-2 small-12">\n                                    <div class="wide-carousel__media-wrapper">\n                                       <video poster="" muted="true" onloadedmetadata="this.muted = true">\n                                          <source src="/_assets/videos/core/homepage/city_community.mp4" type="video/mp4">\n                                       </video><img src="" alt="Union Station" class="orbit-image"></div>\n                                 </div>\n                                 <div class="columns order-2 medium-order-1 small-12 wide-carousel__content medium-6 medium-offset-5">\n                                    \n                                    <p><strong>Denver is one of the nation\xe2\x80\x99s best cities for new careers.</strong> No matter your interests, you\xe2\x80\x99ll be in the perfect place to embark on a fulfilling\n                                       professional life. With a thriving startup scene and a vibrant arts culture, Denver\n                                       is more than just a place to spend your college years\xe2\x80\x94over 70 percent of our undergraduates&nbsp;decide\n                                       to make their homes in Colorado after graduation.\n                                    </p>\n                                    \n                                 </div>\n                              </div>\n                           </div>\n                        </div>\n                        <nav class="orbit-bullets show-for-small-only"><button data-slide="0" class="is-active"><span class="show-for-sr">\n                                 \n                                 <p><strong>Our campus is built to inspire.</strong> Nestled in the Denver metro area, our 125 acres are minutes from downtown and a stone\xe2\x80\x99s\n                                    throw from the Rocky Mountains. With 300 days of sunshine and beautiful sights in\n                                    the middle of winter, this is a place you\'ll be excited to call your home.\n                                 </p>\n                                 </span></button><button data-slide="1"><span class="show-for-sr">\n                                 \n                                 <p><strong>Denver is one of the nation\xe2\x80\x99s best cities for new careers.</strong> No matter your interests, you\xe2\x80\x99ll be in the perfect place to embark on a fulfilling\n                                    professional life. With a thriving startup scene and a vibrant arts culture, Denver\n                                    is more than just a place to spend your college years\xe2\x80\x94over 70 percent of our undergraduates&nbsp;decide\n                                    to make their homes in Colorado after graduation.\n                                 </p>\n                                 </span></button></nav>\n                     </div>\n                  </div>\n               </div>\n               <!--END Wide Carousel: Alt Layout-->\n               \n               <p>&nbsp;</p>\n               <!--BEGIN Three Column Facts-->\n               <div class="row">\n                  <div class="columns small-12 medium-5 medium-offset-7">\n                     \n                     <h3 class="top-divider"><strong>Denver</strong> Is Your Laboratory\n                     </h3>\n                     \n                  </div>\n               </div>\n               <div id="threeColFacts" class="row three-col-facts" style="background-image: url(\'\');">\n                  <div class="columns small-12 medium-4 three-col-facts__item">\n                     \n                     <p><strong>110</strong> student-run organizations\n                     </p>\n                     \n                  </div>\n                  <div class="columns small-12 medium-4 three-col-facts__item">\n                     \n                     <p><strong>19,000</strong> acres of park space in Denver\n                     </p>\n                     \n                  </div>\n                  <div class="columns small-12 medium-4 three-col-facts__item">\n                     \n                     <p><strong>6th</strong> fastest-growing metro area\n                     </p>\n                     \n                  </div>\n               </div>\n               <!--END Three Column Facts-->\n               \n               <p>&nbsp;</p>\n               \t\t\n               <!--BEGIN Academic Programs Search-->\n               <form name="program-search" id="home-prgm-search" action="/academics/undergraduate-programs.html" method="get" class="row du-home__academic-programs">\n                  <div class="columns small-12">\n                     \t\t\t\t\t\t\n                     <h2 class="btm-divider text-center">Break New <strong>Ground</strong></h2>\n                     \t\t\t\t\t\n                  </div>\n                  <div class="columns small-12 medium-10 medium-offset-1">\n                     <div class="search-box"><label class="show-for-sr" for="searchAcademicPrograms" aria-label="search-label">Search Input</label><input name="search" id="searchAcademicPrograms" placeholder="Explore Academic Programs" type="text"><button type="submit"><span class="icon-du-cust-search" aria-hidden="true"></span><span class="show-for-sr">Submit Search</span></button></div>\n                     <div class="row">\n                        <div class="columns small-12 medium-6"><button class="btn" type="submit" id="search-ug" onclick="duGA_createEvent(\'Homepage\',\'Program Search\', \'Undergrad\')">Search Undergraduate Programs<span class="icon-du-cust-search" aria-hidden="true"></span></button></div>\n                        <div class="columns small-12 medium-6"><button class="btn" type="submit" id="search-gr" onclick="duGA_createEvent(\'Homepage\',\'Program Search\', \'Graduate\')">Search Graduate Programs<span class="icon-du-cust-search" aria-hidden="true"></span></button></div>\n                     </div>\n                  </div>\n               </form>\n               <!--END Academic Programs Search-->\n               \t\n            </article>\n            <footer>\n               <div class="has-gray-band">\n                  \n                  <div class="row">\n                     \n                     <div class="columns small-12 medium-4"><a title="Request Information about the University of Denver" href="#" data-toggle="modal_footer_cta_request_info" class="bg-img-btn" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'request_info-open\')"><img src="/_assets/images/core/fpo/footer-btn-img1.jpg" alt="students in class" width="386" height="235"><div class="content"><img src="/_assets/images/core/fpo/footer-icon-request-info.png" alt="request info" width="74" height="81"><p>Request Info</p>\n                           </div></a></div>\n                     \n                     <div class="columns small-12 medium-4"><a title="Apply to the University of Denver" href="#" data-toggle="modal_footer_cta_apply" class="bg-img-btn" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'apply-open\')"><img src="/_assets/images/core/fpo/footer-btn-img2.jpg" alt="DU fans" width="386" height="235"><div class="content"><img src="/_assets/images/core/fpo/footer-icon-apply.png" alt="apply" width="67" height="80"><p>Apply to DU</p>\n                           </div></a></div>\n                     \n                     <div class="columns small-12 medium-4"><a title="Find your program representative and schedule a visit" href="#" data-toggle="modal_footer_cta_visit" class="bg-img-btn" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'visit-open\')"><img src="/_assets/images/core/fpo/footer-btn-img3.jpg" alt="campus panorama" width="386" height="235"><div class="content"><img src="/_assets/images/core/fpo/footer-icon-visit.png" alt="visit DU" width="115" height="79"><p>Visit DU</p>\n                           </div></a></div>\n                     \n                  </div>\n                  \n               </div>\n               \n               <!-- Footer CTA Modals -->\n               \n               <!-- REQUEST INFO -->\n               \n               <div class="full reveal" id="modal_footer_cta_request_info" data-reveal="data-reveal" data-animation-in="fade-in" data-animation-out="fade-out">\n                  \n                  <div class="row align-center modal_wrapper">\n                     \n                     <div class="columns align-self-middle modal_cta_utility">\n                        \n                        <div class="row align-center">\n                           \n                           <div class="columns small-12">\n                              \n                              <h2 class="btm-divider text-center">Take The <strong>First Step</strong></h2>\n                              \n                           </div>\n                           \n                        </div>\n                        \n                        <div class="row align-center">\n                           \n                           <div class="columns small-12 medium-4 text-center">\n                              \n                              <h4>Undergraduates</h4>\n                              \n                              <p>Contact Undergraduate Admission</p>\n                              \n                              <p>\n                                 <a role="button" class="btn" title="Request Info from Undergraduate Admission" href="https://admission.du.edu/register/requestinformation" target="_blank" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'request_info-undergraduate\')">Request Info</a>\n                                 \n                              </p>\n                              \n                           </div>\n                           \n                           <div class="columns small-12 medium-4 medium-offset-1 text-center">\n                              \n                              <h4>Graduates</h4>\n                              \n                              <p>Request Graduate Program Information</p>\n                              \n                              <p>\n                                 <a role="button" class="btn" title="Request Info from Graduate Admission" href="/admission-aid/graduate/request-info.html" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'request_info-graduate\')">Request Info</a>\n                                 \n                              </p>\n                              \n                           </div>\n                           \n                        </div>\n                        \n                     </div>\n                     \n                  </div>\n                  <button class="close-button" data-close="" aria-label="Close reveal" type="button">\n                     <span aria-hidden="true">\xc3\x97</span>\n                     </button>\n                  \n               </div>\n               \n               <!-- VISIT -->\n               \n               <div class="full reveal" id="modal_footer_cta_visit" data-reveal="data-reveal" data-animation-in="fade-in" data-animation-out="fade-out">\n                  \n                  <div class="row align-center modal_wrapper">\n                     \n                     <div class="columns align-self-middle modal_cta_utility">\n                        \n                        <div class="row align-center">\n                           \n                           <div class="columns small-12">\n                              \n                              <h2 class="btm-divider text-center">See Our <strong>Campus</strong></h2>\n                              \n                           </div>\n                           \n                        </div>\n                        \n                        <div class="row align-center">\n                           \n                           <div class="columns small-12 medium-4 text-center">\n                              \n                              <h4>Undergraduates</h4>\n                              \n                              <p>View our visit options and schedule your trip to DU.<br><br></p>\n                              \n                              <p>\n                                 <a role="button" class="btn" title="Schedule your undergraduate visit" href="/admission-aid/undergraduate/visit/index.html" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'visit-undergraduate\')">Schedule a Visit</a>\n                                 \n                              </p>\n                              \n                           </div>\n                           \n                           <div class="columns small-12 medium-4 medium-offset-1 text-center">\n                              \n                              <h4>Graduates</h4>\n                              \n                              <p>Find your graduate program representative and schedule a visit.</p>\n                              \n                              <p>\n                                 <a role="button" class="btn" title="Schedule your graduate visit" href="/admission-aid/graduate/visit-your-program.html" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'visit-graduate\')">Schedule a Visit</a>\n                                 \n                              </p>\n                              \n                           </div>\n                           \n                        </div>\n                        \n                     </div>\n                     \n                  </div>\n                  <button class="close-button" data-close="" aria-label="Close reveal" type="button">\n                     <span aria-hidden="true">\xc3\x97</span>\n                     </button>\n                  \n               </div>\n               \n               <!-- APPLY -->\n               \n               <div class="full reveal" id="modal_footer_cta_apply" data-reveal="data-reveal" data-animation-in="fade-in" data-animation-out="fade-out">\n                  \n                  <div class="row align-center modal_wrapper">\n                     \n                     <div class="columns align-self-middle modal_cta_utility">\n                        \n                        <div class="row align-center">\n                           \n                           <div class="columns small-12">\n                              \n                              <h2 class="btm-divider text-center">Start Your <strong>Application</strong></h2>\n                              \n                           </div>\n                           \n                        </div>\n                        \n                        <div class="row">\n                           \n                           <div class="columns small-12 medium-4">\n                              \n                              <h5>Undergraduate Applicants</h5>\n                              \n                           </div>\n                           \n                           <div class="columns small-12 medium-8">\n                              \n                              <p>We accept both the Common App and our own Pioneer App. The Common App is a universal\n                                 application that can be sent to many schools, while the Pioneer App is only used by\n                                 the University of Denver.\n                              </p>\n                              \n                           </div>\n                           \n                           <hr style="width:100%">\n                           \n                        </div>\n                        \n                        <div class="row align-center">\n                           \n                           <div class="columns small-12 medium-3 text-center">\n                              \n                              <h6>Pioneer App</h6>\n                              \n                              <p>\n                                 <a role="button" class="btn" title="Start a Pioneer App for First Years" href="https://denveradmission.du.edu/web" target="_blank" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'apply-undergraduate-fys_pioneer_app\')">First-Year Students</a>\n                                 <a role="button" class="btn" title="Start a Pioneer App for Transfer Students" href="https://denveradmission.du.edu/transfer" target="_blank" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'apply-undergraduate-trs_pioneer_app\')">Transfer Students</a>\n                                 \n                              </p>\n                              \n                           </div>\n                           \n                           <div class="columns small-12 medium-3 medium-offset-1 text-center">\n                              \n                              <h6>Common App</h6>\n                              \n                              <p>\n                                 <a role="button" class="btn" title="Start a Common App for First Years" href="https://apply.commonapp.org/login?m=78" target="_blank" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'apply-undergraduate-fys_common_app\')">First-Year Students</a>\n                                 <a role="button" class="btn" title="Start a Common App for Transfer Students" href="https://apply.commonapp.org/login?m=78" target="_blank" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'apply-undergraduate-trs_common_app\')">Transfer Students</a>\n                                 \n                              </p>\n                              \n                           </div>\n                           \n                           <div class="columns small-12 medium-3 medium-offset-1 text-center">\n                              \n                              <h6>Bachelor Completions</h6>\n                              \n                              <p>\n                                 <a role="button" class="btn" title="Start an Appliction" href="https://gradadmissions.du.edu/apply/" target="_blank" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'apply-undergraduate-bachelor_completion\')">All Students</a>\n                                 \n                              </p>\n                              \n                           </div>\n                           \n                        </div>\n                        \n                        <div class="row columns">\n                           <p>&nbsp;</p>\n                        </div>\n                        \n                        <div class="row">\n                           \n                           <div class="columns small-12 medium-4">\n                              \n                              <h5>Graduate Applicants</h5>\n                              \n                           </div>\n                           \n                           <div class="columns small-12 medium-8">\n                              \n                              <p>Go to the graduate admission application to submit your information. For information\n                                 on admission requirements, visit the graduate academic programs page and locate your\n                                 program of interest.\n                              </p>\n                              \n                           </div>\n                           \n                           <hr style="width:100%">\n                           \n                        </div>\n                        \n                        <div class="row align-center">\n                           \n                           <div class="columns small-12 medium-3 text-center">\n                              \n                              <h6>Apply Now</h6>\n                              \n                              <p>\n                                 <a role="button" class="btn" title="Start a Graduation App" href="https://gradadmissions.du.edu/apply/" target="_blank" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'apply-graduate_app\')">Graduate Application</a>\n                                 \n                              </p>\n                              \n                           </div>\n                           \n                           <div class="columns small-12 medium-3 medium-offset-1 text-center">\n                              \n                              <h6>Explore Programs</h6>\n                              \n                              <p>\n                                 <a role="button" class="btn" title="Start a Graduation App" href="/academics/graduate-programs.html" onclick="duGA_createEvent(\'CTA\',\'footer-cta\',\'apply-graduate_programs\')">Graduate Academic Programs</a>\n                                 \n                              </p>\n                              \n                           </div>\n                           \n                           <div class="columns small-12 medium-3 medium-offset-1 text-center">\n                              \n                              <h6>&nbsp;</h6>\n                              \n                              <p>&nbsp;</p>\n                              \n                           </div>\n                           \n                        </div>\n                        \n                     </div>\n                     \n                  </div>\n                  <button class="close-button" data-close="" aria-label="Close reveal" type="button">\n                     <span aria-hidden="true">\xc3\x97</span>\n                     </button>\n                  \n               </div>\n               <div class="follow-us"><div class="row align-middle"><div class="columns small-12 large-3"><h2>Follow Us:</h2></div><div class="columns small-12 large-6"><ul class="menu social-media align-spaced"><li><a title="follow us on facebook" href="http://www.facebook.com/uofdenver" target="_blank"><span class="du-icon-facebook" aria-hidden="true"></span><span class="show-for-sr">Facebook</span></a></li><li><a title="follow us on twitter" href="http://www.twitter.com/uofdenver" target="_blank"><span class="du-icon-twitter" aria-hidden="true"></span><span class="show-for-sr">Twitter</span></a></li><li><a title="follow us on instagram" href="http://www.instagram.com/uofdenver/" target="_blank"><span class="du-icon-instagram" aria-hidden="true"></span><span class="show-for-sr">Instagram</span></a></li><li><a title="follow us on snapchat" href="https://www.snapchat.com/add/uofdenver/" target="_blank"><span class="du-icon-snapchat" aria-hidden="true"></span><span class="show-for-sr">SnapChat</span></a></li><li><a title="follow us on linkedin" href="https://www.linkedin.com/grp/home?gid=35250" target="_blank"><span class="du-icon-linkedin" aria-hidden="true"></span><span class="show-for-sr">LinkedIn</span></a></li><li><a title="follow us on youtube" href="http://www.youtube.com/uofdenver" target="_blank"><span class="du-icon-youtube" aria-hidden="true"></span><span class="show-for-sr">YouTube</span></a></li></ul></div><div class="columns small-12 large-3"><a href="/social-media/index.html" class="follow-us__view-all"><strong>View All <span class="icon-du-right-arrow" aria-hidden="true"></span></strong></a></div></div></div><nav class="bg-dark-gray" aria-label="footer-links"><ul class="menu align-center"><li><a title="Interactive Map and Printable Map PDFs" href="/site-utilities/maps.html">Maps</a></li><li><a title="Jobs at the University of Denver" href="https://dujobs.silkroad.com/" target="_blank">Jobs</a></li><li><a title="Contacting the Unviersity of Denver" href="/site-utilities/contacts.html">Contact</a></li><li><a title="University of Denver Privacy Policy" href="/site-utilities/privacy-policy.html">Privacy Policy</a></li><li><a title="University of Denver Feedback Form" href="/feedback.html" onclick="duGA_createEvent(\'CTA\',\'feedback\',\'open-footer\')">Feedback</a></li></ul></nav><p class="copyright">Copyright <span id="direct-edit">\xc2\xa9</span>\n\t\t&nbsp;<script>(function(){var date = new Date(); document.write(date.getFullYear());})();</script>&nbsp;\n\n\t\tUniversity of Denver. | All rights reserved. | The University of Denver is an equal opportunity affirmative action institution <span id="du-loader" aria-hidden="true"><span class="icon-du-spin3 animate-spin"></span></span></p>            </footer>\n         </div>\n      </div>\n<!-- Compressed JavaScript -->\n<script src="//cdnjs.cloudflare.com/ajax/libs/foundation/6.3.0/js/foundation.min.js"></script>\n\n<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.isotope/2.2.2/isotope.pkgd.min.js" type="text/javascript"></script>\n<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-scrollTo/2.1.0/jquery.scrollTo.min.js"></script>\n\n<script src="/_duresources/foundation/js/app.js" type="text/javascript"></script>\n<script src="/_duresources/foundation/js/jquery.table-scroll.js" type="text/javascript"></script>\n<script src="/_duresources/foundation/js/jquery-scrolldepth-min.js" type="text/javascript"></script>\n<script>\njQuery(function() {\n  jQuery.scrollDepth({\n    eventHandler: function(data) {\n      console.log(data)\n\t  duGA_createEvent(data)\n    }\n  });\n});\n</script>\n<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js" type="text/javascript"></script>\n\n<!--script type="text/javascript">\nwindow.loop11_key = "4c2e3a41463d71711872ba186b5907bf8d54eca5";\n</script>\n<script src="//cdn.loop11.com/my/loop11.js" type="text/javascript" async="async"></script-->      <div id="hidden" style="display:none;">\n         <a id="de" href="http://a.cms.omniupdate.com/10?skin=du&amp;account=du&amp;site=www&amp;action=de&amp;path=/index.pcf" rel="nofollow">\xc2\xa9</a>\n      </div>\n   </body>\n</html>'


## On Headers

Why create a 'request'? Sometimes you want to specify information beyond the url, which browsers sends in a 'header'. e.g.

- Define a browser: Some websites don't accept connections if Chrome/Firefox/Safari/Edge aren't identified
- Add password information
- Specify view condition, like fetching a mobile version of a site

Defining a header:

```python
hdr = {'User-Agent': 'Mozilla/5.0'}
req = urllib.request.Request(url, headers=hdr)
```


```python
url = "https://www.congress.gov/search?q=%7B%22source%22%3A%22legislation%22%7D"
hdr = {'User-Agent': 'Mozilla/5.0'}
req = urllib.request.Request(url, headers=hdr)
page = urllib.request.urlopen(req)
```

[LINK](https://www.congress.gov/search?q=%7B%22source%22%3A%22legislation%22%7D)
![](../images/congress1.png)

## Parsing the Page


```python
soup = BeautifulSoup(page, 'html.parser')
```

e.g.


```python
soup.find('a')
```




    <a href="https://www.congress.gov"><img alt="Congress.gov" height="28" src="/img/svg/congress-gov-logo.svg" width="302"/></a>



An HTML page parsed with BeautifulSoup treats HTML elements as a complex object, rather than simply a string. Useful methods exist for working with such object, including:

- `el.find(name=tag)` - Find the first matching HTML element of type 'tag'
- `el.find_all(name=tag)` - Returns a list of all matching elements
- `el.children` - Return a list of all elements that are direct children of the current element.
- `el.text` - Extract only the text between tags in the element.
- `el.attrs` - Dictionary (like a JSON object) of element tag elements


```python
first_link = soup.find('a')
first_link.attrs
```




    {'href': 'https://www.congress.gov'}




```python
list(first_link.children)
```




    [<img alt="Congress.gov" height="28" src="/img/svg/congress-gov-logo.svg" width="302"/>]



Use tab autocomplete to see what methods are available!

![](../images/congress1.png)

![](../images/congress2.png)

![](../images/congress3.png)


```python
ordered = soup.find('ol', attrs={'class':'basic-search-results-lists'})
ordered
```




    <ol class="basic-search-results-lists expanded-view" start="1"><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        1.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5983?r=1">H.R.5983</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Communications Act of 1934 to require providers of a covered service to provide location information concerning the telecommunications device of a user of such service to an investigative or law enforcement officer or an employee or other agent of a public safety answering point in an emergency situation involving risk of death or serious physical harm or in order to respond to the user's call for emergency services.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/kevin-yoder/Y000063" target="_blank">Rep. Yoder, Kevin [R-KS-3]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5983/cosponsors?r=1&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/25/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5983/all-actions?r=1&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    1.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5983?r=1">H.R.5983</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Communications Act of 1934 to require providers of a covered service to provide location information concerning the telecommunications device of a user of such service to an investigative or law enforcement officer or an employee or other agent of a public safety answering point in an emergency situation involving risk of death or serious physical harm or in order to respond to the user's call for emergency services.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/kevin-yoder/Y000063" target="_blank">Rep. Yoder, Kevin [R-KS-3]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5983/cosponsors?r=1&amp;overview=closed#tabs">2</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/25/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5983/all-actions?r=1&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        2.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5982?r=2">H.R.5982</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend title 5, United States Code, to increase the gratuity owed upon death of an employee in connection with the employee's service with an Armed Force, to limit the amount of any death gratuity paid upon the death of a Member of Congress, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/jackie-walorski/W000813" target="_blank">Rep. Walorski, Jackie [R-IN-2]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5982/cosponsors?r=2&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce, House Administration        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/25/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on House Administration, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5982/all-actions?r=2&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    2.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5982?r=2">H.R.5982</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend title 5, United States Code, to increase the gratuity owed upon death of an employee in connection with the employee's service with an Armed Force, to limit the amount of any death gratuity paid upon the death of a Member of Congress, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/jackie-walorski/W000813" target="_blank">Rep. Walorski, Jackie [R-IN-2]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5982/cosponsors?r=2&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce, House Administration</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/25/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on House Administration, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5982/all-actions?r=2&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        3.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5981?r=3">H.R.5981</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend title 44, United States Code, to prohibit the Archivist from charging certain fees to veterans for destroyed records regarding such veterans, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/christopher-smith/S000522" target="_blank">Rep. Smith, Christopher H. [R-NJ-4]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5981/cosponsors?r=3&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Oversight and Government Reform        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/25/2018 Referred to the House Committee on Oversight and Government Reform. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5981/all-actions?r=3&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    3.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5981?r=3">H.R.5981</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend title 44, United States Code, to prohibit the Archivist from charging certain fees to veterans for destroyed records regarding such veterans, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/christopher-smith/S000522" target="_blank">Rep. Smith, Christopher H. [R-NJ-4]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5981/cosponsors?r=3&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Oversight and Government Reform</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/25/2018 Referred to the House Committee on Oversight and Government Reform. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5981/all-actions?r=3&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        4.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5980?r=4">H.R.5980</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To authorize, develop, and implement a coordinated tracking system of federally-funded initiatives and grant programs for substance abuse treatment, prevention, and enforcement, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/keith-rothfus/R000598" target="_blank">Rep. Rothfus, Keith J. [R-PA-12]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5980/cosponsors?r=4&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Oversight and Government Reform        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/25/2018 Referred to the House Committee on Oversight and Government Reform. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5980/all-actions?r=4&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    4.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5980?r=4">H.R.5980</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To authorize, develop, and implement a coordinated tracking system of federally-funded initiatives and grant programs for substance abuse treatment, prevention, and enforcement, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/keith-rothfus/R000598" target="_blank">Rep. Rothfus, Keith J. [R-PA-12]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5980/cosponsors?r=4&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Oversight and Government Reform</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/25/2018 Referred to the House Committee on Oversight and Government Reform. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5980/all-actions?r=4&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        5.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5979?r=5">H.R.5979</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To establish the Mill Springs Battlefield National Monument in the State of Kentucky as a unit of the National Park System, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/harold-rogers/R000395" target="_blank">Rep. Rogers, Harold [R-KY-5]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5979/cosponsors?r=5&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Natural Resources        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/25/2018 Referred to the House Committee on Natural Resources. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5979/all-actions?r=5&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    5.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5979?r=5">H.R.5979</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To establish the Mill Springs Battlefield National Monument in the State of Kentucky as a unit of the National Park System, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/harold-rogers/R000395" target="_blank">Rep. Rogers, Harold [R-KY-5]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5979/cosponsors?r=5&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Natural Resources</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/25/2018 Referred to the House Committee on Natural Resources. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5979/all-actions?r=5&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        6.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5978?r=6">H.R.5978</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Food Security Act of 1985 to provide for certain payment limitations with respect to commodity programs, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/mark-meadows/M001187" target="_blank">Rep. Meadows, Mark [R-NC-11]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5978/cosponsors?r=6&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Agriculture        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/25/2018 Referred to the House Committee on Agriculture. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5978/all-actions?r=6&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    6.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5978?r=6">H.R.5978</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Food Security Act of 1985 to provide for certain payment limitations with respect to commodity programs, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/mark-meadows/M001187" target="_blank">Rep. Meadows, Mark [R-NC-11]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5978/cosponsors?r=6&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Agriculture</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/25/2018 Referred to the House Committee on Agriculture. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5978/all-actions?r=6&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        7.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5977?r=7">H.R.5977</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To improve Federal efforts with respect to the prevention of maternal mortality, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/robin-kelly/K000385" target="_blank">Rep. Kelly, Robin L. [D-IL-2]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5977/cosponsors?r=7&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/25/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5977/all-actions?r=7&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    7.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5977?r=7">H.R.5977</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To improve Federal efforts with respect to the prevention of maternal mortality, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/robin-kelly/K000385" target="_blank">Rep. Kelly, Robin L. [D-IL-2]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5977/cosponsors?r=7&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/25/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5977/all-actions?r=7&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        8.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5976?r=8">H.R.5976</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Individuals with Disabilities Education Act to direct the Secretary to provide additional funds to States to establish and make disbursements from high cost funds.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/jared-huffman/H001068" target="_blank">Rep. Huffman, Jared [D-CA-2]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5976/cosponsors?r=8&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/25/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5976/all-actions?r=8&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    8.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5976?r=8">H.R.5976</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Individuals with Disabilities Education Act to direct the Secretary to provide additional funds to States to establish and make disbursements from high cost funds.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/jared-huffman/H001068" target="_blank">Rep. Huffman, Jared [D-CA-2]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5976/cosponsors?r=8&amp;overview=closed#tabs">2</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/25/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5976/all-actions?r=8&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        9.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5975?r=9">H.R.5975</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To support businesses in Puerto Rico, extend child tax credits for families in Puerto Rico, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/jenniffer-gonzalez-colon/G000582" target="_blank">Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5975/cosponsors?r=9&amp;overview=closed#tabs">5</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Ways and Means, Small Business, Financial Services, Oversight and Government Reform, Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/25/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Small Business, Financial Services, Oversight and Government Reform, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5975/all-actions?r=9&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    9.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5975?r=9">H.R.5975</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To support businesses in Puerto Rico, extend child tax credits for families in Puerto Rico, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/jenniffer-gonzalez-colon/G000582" target="_blank">Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5975/cosponsors?r=9&amp;overview=closed#tabs">5</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Ways and Means, Small Business, Financial Services, Oversight and Government Reform, Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/25/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Small Business, Financial Services, Oversight and Government Reform, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5975/all-actions?r=9&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        10.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5974?r=10">H.R.5974</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To direct the Secretary of Veterans Affairs to use on-site regulated medical waste treatment systems at certain Department of Veterans Affairs facilities, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/jeff-denham/D000612" target="_blank">Rep. Denham, Jeff [R-CA-10]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5974/cosponsors?r=10&amp;overview=closed#tabs">3</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Veterans' Affairs        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/25/2018 Referred to the House Committee on Veterans' Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5974/all-actions?r=10&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    10.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5974?r=10">H.R.5974</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To direct the Secretary of Veterans Affairs to use on-site regulated medical waste treatment systems at certain Department of Veterans Affairs facilities, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/jeff-denham/D000612" target="_blank">Rep. Denham, Jeff [R-CA-10]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5974/cosponsors?r=10&amp;overview=closed#tabs">3</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Veterans' Affairs</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/25/2018 Referred to the House Committee on Veterans' Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5974/all-actions?r=10&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        11.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5973?r=11">H.R.5973</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Robert T. Stafford Disaster Relief and Emergency Assistance Act to require a report on risk transfer, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/dennis-ross/R000593" target="_blank">Rep. Ross, Dennis A. [R-FL-15]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5973/cosponsors?r=11&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Transportation and Infrastructure        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/25/2018 Referred to the House Committee on Transportation and Infrastructure. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5973/all-actions?r=11&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    11.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5973?r=11">H.R.5973</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Robert T. Stafford Disaster Relief and Emergency Assistance Act to require a report on risk transfer, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/dennis-ross/R000593" target="_blank">Rep. Ross, Dennis A. [R-FL-15]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5973/cosponsors?r=11&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Transportation and Infrastructure</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/25/2018 Referred to the House Committee on Transportation and Infrastructure. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5973/all-actions?r=11&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        12.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5972?r=12">H.R.5972</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend section 502 of title 40, United States Code, to allow State and local governments to purchase from the Federal supply schedule, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/lee-zeldin/Z000017" target="_blank">Rep. Zeldin, Lee M. [R-NY-1]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5972/cosponsors?r=12&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Oversight and Government Reform        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the House Committee on Oversight and Government Reform. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5972/all-actions?r=12&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    12.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5972?r=12">H.R.5972</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend section 502 of title 40, United States Code, to allow State and local governments to purchase from the Federal supply schedule, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/lee-zeldin/Z000017" target="_blank">Rep. Zeldin, Lee M. [R-NY-1]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5972/cosponsors?r=12&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Oversight and Government Reform</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the House Committee on Oversight and Government Reform. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5972/all-actions?r=12&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        13.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5971?r=13">H.R.5971</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To include nonprofit and volunteer ground and air ambulance crew members and first responders for certain benefits.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/lee-zeldin/Z000017" target="_blank">Rep. Zeldin, Lee M. [R-NY-1]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5971/cosponsors?r=13&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Judiciary        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5971/all-actions?r=13&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    13.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5971?r=13">H.R.5971</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To include nonprofit and volunteer ground and air ambulance crew members and first responders for certain benefits.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/lee-zeldin/Z000017" target="_blank">Rep. Zeldin, Lee M. [R-NY-1]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5971/cosponsors?r=13&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Judiciary</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5971/all-actions?r=13&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        14.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5970?r=14">H.R.5970</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To require the Securities and Exchange Commission to implement rules simplifying the quarterly financial reporting regime.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/ann-wagner/W000812" target="_blank">Rep. Wagner, Ann [R-MO-2]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5970/cosponsors?r=14&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Financial Services        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the House Committee on Financial Services. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5970/all-actions?r=14&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    14.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5970?r=14">H.R.5970</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To require the Securities and Exchange Commission to implement rules simplifying the quarterly financial reporting regime.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/ann-wagner/W000812" target="_blank">Rep. Wagner, Ann [R-MO-2]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5970/cosponsors?r=14&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Financial Services</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the House Committee on Financial Services. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5970/all-actions?r=14&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        15.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5969?r=15">H.R.5969</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To prohibit the use of Federal funds for the provision of broadband service in any State that has in effect a law, regulation, or other requirement that prohibits, limits, places conditions on, or regulates the provision of broadband service by public, cooperative, or nonprofit broadband providers.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/mark-pocan/P000607" target="_blank">Rep. Pocan, Mark [D-WI-2]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5969/cosponsors?r=15&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5969/all-actions?r=15&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    15.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5969?r=15">H.R.5969</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To prohibit the use of Federal funds for the provision of broadband service in any State that has in effect a law, regulation, or other requirement that prohibits, limits, places conditions on, or regulates the provision of broadband service by public, cooperative, or nonprofit broadband providers.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/mark-pocan/P000607" target="_blank">Rep. Pocan, Mark [D-WI-2]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5969/cosponsors?r=15&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5969/all-actions?r=15&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        16.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5968?r=16">H.R.5968</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To encourage online workforce training.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/rick-larsen/L000560" target="_blank">Rep. Larsen, Rick [D-WA-2]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5968/cosponsors?r=16&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5968/all-actions?r=16&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    16.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5968?r=16">H.R.5968</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To encourage online workforce training.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/rick-larsen/L000560" target="_blank">Rep. Larsen, Rick [D-WA-2]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5968/cosponsors?r=16&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5968/all-actions?r=16&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        17.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5967?r=17">H.R.5967</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To establish a single export promotion agency in the executive branch, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/ann-kuster/K000382" target="_blank">Rep. Kuster, Ann M. [D-NH-2]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5967/cosponsors?r=17&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Foreign Affairs        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the House Committee on Foreign Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5967/all-actions?r=17&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    17.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5967?r=17">H.R.5967</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To establish a single export promotion agency in the executive branch, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/ann-kuster/K000382" target="_blank">Rep. Kuster, Ann M. [D-NH-2]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5967/cosponsors?r=17&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Foreign Affairs</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the House Committee on Foreign Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5967/all-actions?r=17&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        18.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5966?r=18">H.R.5966</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To improve the provision of health care for women veterans by the Department of Veterans Affairs, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/william-keating/K000375" target="_blank">Rep. Keating, William R. [D-MA-9]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5966/cosponsors?r=18&amp;overview=closed#tabs">3</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Veterans' Affairs        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the House Committee on Veterans' Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5966/all-actions?r=18&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    18.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5966?r=18">H.R.5966</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To improve the provision of health care for women veterans by the Department of Veterans Affairs, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/william-keating/K000375" target="_blank">Rep. Keating, William R. [D-MA-9]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5966/cosponsors?r=18&amp;overview=closed#tabs">3</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Veterans' Affairs</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the House Committee on Veterans' Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5966/all-actions?r=18&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        19.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5965?r=19">H.R.5965</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To require health insurance coverage for the treatment of infertility.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/rosa-delauro/D000216" target="_blank">Rep. DeLauro, Rosa L. [D-CT-3]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5965/cosponsors?r=19&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce, Oversight and Government Reform, Armed Services, Veterans' Affairs        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committees on Oversight and Government Reform, Armed Services, and Veterans' Affairs, for a period to be subsequently determined by the Speaker, in each case for consideration of such... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5965/all-actions?r=19&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    19.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5965?r=19">H.R.5965</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To require health insurance coverage for the treatment of infertility.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/rosa-delauro/D000216" target="_blank">Rep. DeLauro, Rosa L. [D-CT-3]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5965/cosponsors?r=19&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce, Oversight and Government Reform, Armed Services, Veterans' Affairs</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committees on Oversight and Government Reform, Armed Services, and Veterans' Affairs, for a period to be subsequently determined by the Speaker, in each case for consideration of such... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5965/all-actions?r=19&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        20.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5964?r=20">H.R.5964</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Professional Boxing Safety Act of 1996 to provide additional safety standards for professional boxing.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/matt-cartwright/C001090" target="_blank">Rep. Cartwright, Matt [D-PA-17]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5964/cosponsors?r=20&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce, Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5964/all-actions?r=20&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    20.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5964?r=20">H.R.5964</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Professional Boxing Safety Act of 1996 to provide additional safety standards for professional boxing.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/matt-cartwright/C001090" target="_blank">Rep. Cartwright, Matt [D-PA-17]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5964/cosponsors?r=20&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce, Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5964/all-actions?r=20&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        21.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5963?r=21">H.R.5963</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To delay the reimposition of the annual fee on health insurance providers until after 2020.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/kristi-noem/N000184" target="_blank">Rep. Noem, Kristi L. [R-SD-At Large]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5963/cosponsors?r=21&amp;overview=closed#tabs">3</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Ways and Means, Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5963/all-actions?r=21&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    21.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5963?r=21">H.R.5963</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To delay the reimposition of the annual fee on health insurance providers until after 2020.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/kristi-noem/N000184" target="_blank">Rep. Noem, Kristi L. [R-SD-At Large]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5963/cosponsors?r=21&amp;overview=closed#tabs">3</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Ways and Means, Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5963/all-actions?r=21&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        22.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5962?r=22">H.R.5962</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To provide for loan forgiveness for STEM teachers, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/eric-swalwell/S001193" target="_blank">Rep. Swalwell, Eric [D-CA-15]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5962/cosponsors?r=22&amp;overview=closed#tabs">4</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Ways and Means, Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5962/all-actions?r=22&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    22.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5962?r=22">H.R.5962</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To provide for loan forgiveness for STEM teachers, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/eric-swalwell/S001193" target="_blank">Rep. Swalwell, Eric [D-CA-15]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5962/cosponsors?r=22&amp;overview=closed#tabs">4</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Ways and Means, Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5962/all-actions?r=22&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        23.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5961?r=23">H.R.5961</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">Making appropriations for Agriculture, Rural Development, Food and Drug Administration, and Related Agencies programs for the fiscal year ending September 30, 2019, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/robert-aderholt/A000055" target="_blank">Rep. Aderholt, Robert B. [R-AL-4]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5961/cosponsors?r=23&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Appropriations        </span>
    <span class="result-item">
    <strong>Committee Reports:</strong> <a href="/congressional-report/115th-congress/house-report/706/1" target="_blank">H. Rept. 115-706</a> </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Placed on the Union Calendar, Calendar No. 545. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5961/all-actions?r=23&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; The House Committee on Appropriations reported an original measure, H. Rept. 115-706, by Mr. Aderholt.
        [externalActionCode] =&gt; 5000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    23.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5961?r=23">H.R.5961</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">Making appropriations for Agriculture, Rural Development, Food and Drug Administration, and Related Agencies programs for the fiscal year ending September 30, 2019, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/robert-aderholt/A000055" target="_blank">Rep. Aderholt, Robert B. [R-AL-4]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5961/cosponsors?r=23&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Appropriations</span>
    </span>
    <span class="result-item">
    <strong>Committee Reports:</strong>
    <span><a href="/congressional-report/115th-congress/house-report/706/1" target="_blank">H. Rept. 115-706</a></span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Placed on the Union Calendar, Calendar No. 545. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5961/all-actions?r=23&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; The House Committee on Appropriations reported an original measure, H. Rept. 115-706, by Mr. Aderholt.
        [externalActionCode] =&gt; 5000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        24.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5960?r=24">H.R.5960</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To direct the Attorney General to make grants to regional gang task forces to prevent violence committed by and against youths, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/gerald-connolly/C001078" target="_blank">Rep. Connolly, Gerald E. [D-VA-11]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5960/cosponsors?r=24&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Judiciary        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5960/all-actions?r=24&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    24.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5960?r=24">H.R.5960</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To direct the Attorney General to make grants to regional gang task forces to prevent violence committed by and against youths, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/gerald-connolly/C001078" target="_blank">Rep. Connolly, Gerald E. [D-VA-11]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5960/cosponsors?r=24&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Judiciary</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5960/all-actions?r=24&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        25.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5959?r=25">H.R.5959</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To promote national security and jobs through the use of natural gas to fuel heavy-duty trucks and fleet vehicles.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/markwayne-mullin/M001190" target="_blank">Rep. Mullin, Markwayne [R-OK-2]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5959/cosponsors?r=25&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Ways and Means, Oversight and Government Reform, Energy and Commerce, Science, Space, and Technology        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Oversight and Government Reform, Energy and Commerce, and Science, Space, and Technology, for a period to be subsequently determined by the Speaker, in each case for consideration of... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5959/all-actions?r=25&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    25.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5959?r=25">H.R.5959</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To promote national security and jobs through the use of natural gas to fuel heavy-duty trucks and fleet vehicles.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/markwayne-mullin/M001190" target="_blank">Rep. Mullin, Markwayne [R-OK-2]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5959/cosponsors?r=25&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Ways and Means, Oversight and Government Reform, Energy and Commerce, Science, Space, and Technology</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Oversight and Government Reform, Energy and Commerce, and Science, Space, and Technology, for a period to be subsequently determined by the Speaker, in each case for consideration of... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5959/all-actions?r=25&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        26.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5958?r=26">H.R.5958</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend title XVIII of the Social Security Act to require pharmacy-negotiated price concessions and pharmacy incentive payments and adjustments to be included in negotiated prices at the point-of-sale under part D of the Medicare program, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/doug-collins/C001093" target="_blank">Rep. Collins, Doug [R-GA-9]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5958/cosponsors?r=26&amp;overview=closed#tabs">3</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce, Ways and Means        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committee on Ways and Means, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5958/all-actions?r=26&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    26.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5958?r=26">H.R.5958</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend title XVIII of the Social Security Act to require pharmacy-negotiated price concessions and pharmacy incentive payments and adjustments to be included in negotiated prices at the point-of-sale under part D of the Medicare program, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/doug-collins/C001093" target="_blank">Rep. Collins, Doug [R-GA-9]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5958/cosponsors?r=26&amp;overview=closed#tabs">3</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce, Ways and Means</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committee on Ways and Means, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5958/all-actions?r=26&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        27.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5957?r=27">H.R.5957</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To establish the Caddo Lake National Heritage Area, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/louie-gohmert/G000552" target="_blank">Rep. Gohmert, Louie [R-TX-1]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5957/cosponsors?r=27&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Natural Resources        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the House Committee on Natural Resources. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5957/all-actions?r=27&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    27.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5957?r=27">H.R.5957</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To establish the Caddo Lake National Heritage Area, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/louie-gohmert/G000552" target="_blank">Rep. Gohmert, Louie [R-TX-1]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5957/cosponsors?r=27&amp;overview=closed#tabs">2</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Natural Resources</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the House Committee on Natural Resources. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5957/all-actions?r=27&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        28.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5956?r=28">H.R.5956</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To incentivize the hiring of United States workers in the Commonwealth of the Northern Mariana Islands, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/rob-bishop/B001250" target="_blank">Rep. Bishop, Rob [R-UT-1]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5956/cosponsors?r=28&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Natural Resources        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the House Committee on Natural Resources. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5956/all-actions?r=28&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    28.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5956?r=28">H.R.5956</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To incentivize the hiring of United States workers in the Commonwealth of the Northern Mariana Islands, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/rob-bishop/B001250" target="_blank">Rep. Bishop, Rob [R-UT-1]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5956/cosponsors?r=28&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Natural Resources</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the House Committee on Natural Resources. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5956/all-actions?r=28&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        29.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5955?r=29">H.R.5955</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To reauthorize subtitle A of the Victims of Child Abuse Act of 1990.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/ted-poe/P000592" target="_blank">Rep. Poe, Ted [R-TX-2]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5955/cosponsors?r=29&amp;overview=closed#tabs">13</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Judiciary, Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5955/all-actions?r=29&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    29.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5955?r=29">H.R.5955</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To reauthorize subtitle A of the Victims of Child Abuse Act of 1990.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/ted-poe/P000592" target="_blank">Rep. Poe, Ted [R-TX-2]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5955/cosponsors?r=29&amp;overview=closed#tabs">13</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Judiciary, Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5955/all-actions?r=29&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        30.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5954?r=30">H.R.5954</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend title 18, United States Code, to clarify the meaning of the terms "act of war" and "blocked asset", and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/robert-goodlatte/G000289" target="_blank">Rep. Goodlatte, Bob [R-VA-6]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5954/cosponsors?r=30&amp;overview=closed#tabs">4</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Judiciary        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5954/all-actions?r=30&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    30.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5954?r=30">H.R.5954</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend title 18, United States Code, to clarify the meaning of the terms "act of war" and "blocked asset", and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/robert-goodlatte/G000289" target="_blank">Rep. Goodlatte, Bob [R-VA-6]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5954/cosponsors?r=30&amp;overview=closed#tabs">4</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Judiciary</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5954/all-actions?r=30&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        31.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5953?r=31">H.R.5953</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To provide regulatory relief to charitable organizations that provide housing assistance, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/barry-loudermilk/L000583" target="_blank">Rep. Loudermilk, Barry [R-GA-11]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5953/cosponsors?r=31&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Financial Services        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Referred to the House Committee on Financial Services. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5953/all-actions?r=31&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    31.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5953?r=31">H.R.5953</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To provide regulatory relief to charitable organizations that provide housing assistance, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/barry-loudermilk/L000583" target="_blank">Rep. Loudermilk, Barry [R-GA-11]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5953/cosponsors?r=31&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Financial Services</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Referred to the House Committee on Financial Services. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5953/all-actions?r=31&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        32.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5952?r=32">H.R.5952</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">Science Appropriations Act, 2019</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/john-culberson/C001048" target="_blank">Rep. Culberson, John Abney [R-TX-7]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5952/cosponsors?r=32&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Appropriations        </span>
    <span class="result-item">
    <strong>Committee Reports:</strong> <a href="/congressional-report/115th-congress/house-report/704/1" target="_blank">H. Rept. 115-704</a> </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/24/2018 Placed on the Union Calendar, Calendar No. 544. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5952/all-actions?r=32&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; The House Committee on Appropriations reported an original measure, H. Rept. 115-704, by Mr. Culberson.
        [externalActionCode] =&gt; 5000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    32.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5952?r=32">H.R.5952</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">Science Appropriations Act, 2019</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/john-culberson/C001048" target="_blank">Rep. Culberson, John Abney [R-TX-7]</a> (Introduced 05/24/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5952/cosponsors?r=32&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Appropriations</span>
    </span>
    <span class="result-item">
    <strong>Committee Reports:</strong>
    <span><a href="/congressional-report/115th-congress/house-report/704/1" target="_blank">H. Rept. 115-704</a></span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/24/2018 Placed on the Union Calendar, Calendar No. 544. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5952/all-actions?r=32&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-24
        [displayText] =&gt; The House Committee on Appropriations reported an original measure, H. Rept. 115-704, by Mr. Culberson.
        [externalActionCode] =&gt; 5000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        33.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5951?r=33">H.R.5951</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To establish the Veterans Crisis Response Corps, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/adam-schiff/S001150" target="_blank">Rep. Schiff, Adam B. [D-CA-28]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5951/cosponsors?r=33&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Veterans' Affairs, Transportation and Infrastructure, Foreign Affairs, Armed Services        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committees on Transportation and Infrastructure, Foreign Affairs, and Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5951/all-actions?r=33&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    33.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5951?r=33">H.R.5951</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To establish the Veterans Crisis Response Corps, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/adam-schiff/S001150" target="_blank">Rep. Schiff, Adam B. [D-CA-28]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5951/cosponsors?r=33&amp;overview=closed#tabs">2</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Veterans' Affairs, Transportation and Infrastructure, Foreign Affairs, Armed Services</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committees on Transportation and Infrastructure, Foreign Affairs, and Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5951/all-actions?r=33&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        34.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5950?r=34">H.R.5950</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To protect children affected by immigration enforcement actions.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/lucille-roybal-allard/R000486" target="_blank">Rep. Roybal-Allard, Lucille [D-CA-40]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5950/cosponsors?r=34&amp;overview=closed#tabs">6</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Judiciary        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5950/all-actions?r=34&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    34.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5950?r=34">H.R.5950</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To protect children affected by immigration enforcement actions.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/lucille-roybal-allard/R000486" target="_blank">Rep. Roybal-Allard, Lucille [D-CA-40]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5950/cosponsors?r=34&amp;overview=closed#tabs">6</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Judiciary</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5950/all-actions?r=34&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        35.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5949?r=35">H.R.5949</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To exempt certain motor carriers engaged in agricultural business from the electronic logging device requirements, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/collin-peterson/P000258" target="_blank">Rep. Peterson, Collin C. [D-MN-7]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5949/cosponsors?r=35&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Transportation and Infrastructure        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Transportation and Infrastructure. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5949/all-actions?r=35&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    35.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5949?r=35">H.R.5949</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To exempt certain motor carriers engaged in agricultural business from the electronic logging device requirements, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/collin-peterson/P000258" target="_blank">Rep. Peterson, Collin C. [D-MN-7]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5949/cosponsors?r=35&amp;overview=closed#tabs">2</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Transportation and Infrastructure</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Transportation and Infrastructure. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5949/all-actions?r=35&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        36.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5948?r=36">H.R.5948</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To exempt motor carriers that own or operate 10 or fewer commercial vehicles from the electronic logging device mandates, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/collin-peterson/P000258" target="_blank">Rep. Peterson, Collin C. [D-MN-7]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5948/cosponsors?r=36&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Transportation and Infrastructure        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Transportation and Infrastructure. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5948/all-actions?r=36&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    36.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5948?r=36">H.R.5948</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To exempt motor carriers that own or operate 10 or fewer commercial vehicles from the electronic logging device mandates, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/collin-peterson/P000258" target="_blank">Rep. Peterson, Collin C. [D-MN-7]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5948/cosponsors?r=36&amp;overview=closed#tabs">2</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Transportation and Infrastructure</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Transportation and Infrastructure. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5948/all-actions?r=36&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        37.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5947?r=37">H.R.5947</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To repeal the Asia Foundation Act, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/ralph-norman/N000190" target="_blank">Rep. Norman, Ralph [R-SC-5]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5947/cosponsors?r=37&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Foreign Affairs        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Foreign Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5947/all-actions?r=37&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    37.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5947?r=37">H.R.5947</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To repeal the Asia Foundation Act, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/ralph-norman/N000190" target="_blank">Rep. Norman, Ralph [R-SC-5]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5947/cosponsors?r=37&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Foreign Affairs</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Foreign Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5947/all-actions?r=37&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        38.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5946?r=38">H.R.5946</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To provide that Members of Congress shall not be paid if Congress has not approved a concurrent resolution on the budget and passed the regular appropriations bills on a timely basis, to eliminate automatic pay adjustments for Members of Congress, to prohibit the use of funds provided for the official travel expenses of Members of Congress and other officers and employees of the legislative branch for first-class airline accommodations, to establish a lifetime ban on lobbying by former Members of Congress, to prohibit consideration in the House of Representatives of measures lacking demonstrable bipartisan support, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/stephanie-murphy/M001202" target="_blank">Rep. Murphy, Stephanie N. [D-FL-7]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5946/cosponsors?r=38&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - House Administration, Oversight and Government Reform, Judiciary, Rules        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the Committee on House Administration, and in addition to the Committees on Oversight and Government Reform, the Judiciary, and Rules, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5946/all-actions?r=38&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    38.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5946?r=38">H.R.5946</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To provide that Members of Congress shall not be paid if Congress has not approved a concurrent resolution on the budget and passed the regular appropriations bills on a timely basis, to eliminate automatic pay adjustments for Members of Congress, to prohibit the use of funds provided for the official travel expenses of Members of Congress and other officers and employees of the legislative branch for first-class airline accommodations, to establish a lifetime ban on lobbying by former Members of Congress, to prohibit consideration in the House of Representatives of measures lacking demonstrable bipartisan support, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/stephanie-murphy/M001202" target="_blank">Rep. Murphy, Stephanie N. [D-FL-7]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5946/cosponsors?r=38&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - House Administration, Oversight and Government Reform, Judiciary, Rules</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the Committee on House Administration, and in addition to the Committees on Oversight and Government Reform, the Judiciary, and Rules, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5946/all-actions?r=38&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        39.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5945?r=39">H.R.5945</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To encourage, enhance, and integrate Green Alert plans throughout the United States, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/gwen-moore/M001160" target="_blank">Rep. Moore, Gwen [D-WI-4]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5945/cosponsors?r=39&amp;overview=closed#tabs">8</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Judiciary        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5945/all-actions?r=39&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    39.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5945?r=39">H.R.5945</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To encourage, enhance, and integrate Green Alert plans throughout the United States, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/gwen-moore/M001160" target="_blank">Rep. Moore, Gwen [D-WI-4]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5945/cosponsors?r=39&amp;overview=closed#tabs">8</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Judiciary</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5945/all-actions?r=39&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        40.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5944?r=40">H.R.5944</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To improve career and technical education by providing improved educational opportunities and financial assistance for career and technical educators.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/sean-maloney/M001185" target="_blank">Rep. Maloney, Sean Patrick [D-NY-18]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5944/cosponsors?r=40&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5944/all-actions?r=40&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    40.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5944?r=40">H.R.5944</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To improve career and technical education by providing improved educational opportunities and financial assistance for career and technical educators.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/sean-maloney/M001185" target="_blank">Rep. Maloney, Sean Patrick [D-NY-18]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5944/cosponsors?r=40&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5944/all-actions?r=40&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        41.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5943?r=41">H.R.5943</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Carl D. Perkins Career and Technical Education Act of 2006 to improve professional development for career and technical educators.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/sean-maloney/M001185" target="_blank">Rep. Maloney, Sean Patrick [D-NY-18]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5943/cosponsors?r=41&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5943/all-actions?r=41&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    41.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5943?r=41">H.R.5943</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Carl D. Perkins Career and Technical Education Act of 2006 to improve professional development for career and technical educators.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/sean-maloney/M001185" target="_blank">Rep. Maloney, Sean Patrick [D-NY-18]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5943/cosponsors?r=41&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5943/all-actions?r=41&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        42.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5942?r=42">H.R.5942</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To improve the health of minority individuals, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/barbara-lee/L000551" target="_blank">Rep. Lee, Barbara [D-CA-13]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5942/cosponsors?r=42&amp;overview=closed#tabs">57</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce, Ways and Means, Agriculture, Education and the Workforce, Budget, Judiciary, Veterans' Affairs, Armed Services, Natural Resources        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committees on Ways and Means, Agriculture, Education and the Workforce, the Budget, the Judiciary, Veterans' Affairs, Armed Services, and Natural Resources, for a period to be subsequently... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5942/all-actions?r=42&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    42.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5942?r=42">H.R.5942</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To improve the health of minority individuals, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/barbara-lee/L000551" target="_blank">Rep. Lee, Barbara [D-CA-13]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5942/cosponsors?r=42&amp;overview=closed#tabs">57</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce, Ways and Means, Agriculture, Education and the Workforce, Budget, Judiciary, Veterans' Affairs, Armed Services, Natural Resources</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committees on Ways and Means, Agriculture, Education and the Workforce, the Budget, the Judiciary, Veterans' Affairs, Armed Services, and Natural Resources, for a period to be subsequently... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5942/all-actions?r=42&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        43.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5941?r=43">H.R.5941</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To prevent child injuries and deaths by firearms.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/james-langevin/L000559" target="_blank">Rep. Langevin, James R. [D-RI-2]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5941/cosponsors?r=43&amp;overview=closed#tabs">3</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Judiciary, Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5941/all-actions?r=43&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    43.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5941?r=43">H.R.5941</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To prevent child injuries and deaths by firearms.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/james-langevin/L000559" target="_blank">Rep. Langevin, James R. [D-RI-2]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5941/cosponsors?r=43&amp;overview=closed#tabs">3</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Judiciary, Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5941/all-actions?r=43&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        44.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5940?r=44">H.R.5940</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To require the Secretary of Defense to submit to Congress a report on victims in military criminal investigative organization reports, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/ann-kuster/K000382" target="_blank">Rep. Kuster, Ann M. [D-NH-2]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5940/cosponsors?r=44&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Armed Services        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Armed Services. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5940/all-actions?r=44&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    44.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5940?r=44">H.R.5940</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To require the Secretary of Defense to submit to Congress a report on victims in military criminal investigative organization reports, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/ann-kuster/K000382" target="_blank">Rep. Kuster, Ann M. [D-NH-2]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5940/cosponsors?r=44&amp;overview=closed#tabs">2</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Armed Services</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Armed Services. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5940/all-actions?r=44&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        45.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5939?r=45">H.R.5939</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Morris K. Udall and Stewart L. Udall Foundation Act.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/raul-grijalva/G000551" target="_blank">Rep. Grijalva, Raul M. [D-AZ-3]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5939/cosponsors?r=45&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce, Natural Resources        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on Natural Resources, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5939/all-actions?r=45&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    45.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5939?r=45">H.R.5939</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Morris K. Udall and Stewart L. Udall Foundation Act.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/raul-grijalva/G000551" target="_blank">Rep. Grijalva, Raul M. [D-AZ-3]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5939/cosponsors?r=45&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce, Natural Resources</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on Natural Resources, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5939/all-actions?r=45&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        46.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5938?r=46">H.R.5938</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the VA Choice and Quality Employment Act to direct the Secretary of Veterans Affairs to establish a vacancy and recruitment database to facilitate the recruitment of certain members of the Armed Forces to satisfy the occupational needs of the Department of Veterans Affairs, to establish and implement a training and certification program for intermediate care technicians in that Department, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/jenniffer-gonzalez-colon/G000582" target="_blank">Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5938/cosponsors?r=46&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Veterans' Affairs        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Veterans' Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5938/all-actions?r=46&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    46.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5938?r=46">H.R.5938</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the VA Choice and Quality Employment Act to direct the Secretary of Veterans Affairs to establish a vacancy and recruitment database to facilitate the recruitment of certain members of the Armed Forces to satisfy the occupational needs of the Department of Veterans Affairs, to establish and implement a training and certification program for intermediate care technicians in that Department, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/jenniffer-gonzalez-colon/G000582" target="_blank">Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5938/cosponsors?r=46&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Veterans' Affairs</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Veterans' Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5938/all-actions?r=46&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        47.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5937?r=47">H.R.5937</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To designate the facility of the United States Postal Service located at 100 Calle Alondra in San Juan, Puerto Rico, as the "65th Infantry Regiment Post Office Building".</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/jenniffer-gonzalez-colon/G000582" target="_blank">Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5937/cosponsors?r=47&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Oversight and Government Reform        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5937/all-actions?r=47&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    47.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5937?r=47">H.R.5937</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To designate the facility of the United States Postal Service located at 100 Calle Alondra in San Juan, Puerto Rico, as the "65th Infantry Regiment Post Office Building".</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/jenniffer-gonzalez-colon/G000582" target="_blank">Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5937/cosponsors?r=47&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Oversight and Government Reform</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5937/all-actions?r=47&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        48.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5936?r=48">H.R.5936</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the National Security Act of 1947 to require the appointment by the President of the Assistant to the President for National Security Affairs to be made by and with the advice and consent of the Senate.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/bill-foster/F000454" target="_blank">Rep. Foster, Bill [D-IL-11]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5936/cosponsors?r=48&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Armed Services, Foreign Affairs, Intelligence (Permanent Select)        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the Committee on Armed Services, and in addition to the Committees on Foreign Affairs, and Intelligence (Permanent Select), for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5936/all-actions?r=48&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    48.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5936?r=48">H.R.5936</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the National Security Act of 1947 to require the appointment by the President of the Assistant to the President for National Security Affairs to be made by and with the advice and consent of the Senate.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/bill-foster/F000454" target="_blank">Rep. Foster, Bill [D-IL-11]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5936/cosponsors?r=48&amp;overview=closed#tabs">2</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Armed Services, Foreign Affairs, Intelligence (Permanent Select)</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the Committee on Armed Services, and in addition to the Committees on Foreign Affairs, and Intelligence (Permanent Select), for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5936/all-actions?r=48&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        49.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5935?r=49">H.R.5935</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To designate the facility of the United States Postal Service located at 1355 North Meridian Road in Harristown, Illinois, as the "Logan S. Palmer Post Office".</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/rodney-davis/D000619" target="_blank">Rep. Davis, Rodney [R-IL-13]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5935/cosponsors?r=49&amp;overview=closed#tabs">17</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Oversight and Government Reform        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5935/all-actions?r=49&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    49.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5935?r=49">H.R.5935</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To designate the facility of the United States Postal Service located at 1355 North Meridian Road in Harristown, Illinois, as the "Logan S. Palmer Post Office".</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/rodney-davis/D000619" target="_blank">Rep. Davis, Rodney [R-IL-13]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5935/cosponsors?r=49&amp;overview=closed#tabs">17</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Oversight and Government Reform</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5935/all-actions?r=49&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        50.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5934?r=50">H.R.5934</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To designate the facility of the United States Postal Service located at 105 Highway 297 North in Dyess, Arkansas, as the "Johnny Cash Post Office Building".</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/eric-crawford/C001087" target="_blank">Rep. Crawford, Eric A. "Rick" [R-AR-1]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5934/cosponsors?r=50&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Oversight and Government Reform        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5934/all-actions?r=50&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    50.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5934?r=50">H.R.5934</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To designate the facility of the United States Postal Service located at 105 Highway 297 North in Dyess, Arkansas, as the "Johnny Cash Post Office Building".</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/eric-crawford/C001087" target="_blank">Rep. Crawford, Eric A. "Rick" [R-AR-1]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5934/cosponsors?r=50&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Oversight and Government Reform</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5934/all-actions?r=50&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        51.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5933?r=51">H.R.5933</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To prevent substance abuse and reduce demand for illicit narcotics.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/doug-collins/C001093" target="_blank">Rep. Collins, Doug [R-GA-9]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5933/cosponsors?r=51&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Oversight and Government Reform, Judiciary, Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the Committee on Oversight and Government Reform, and in addition to the Committees on the Judiciary, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5933/all-actions?r=51&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    51.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5933?r=51">H.R.5933</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To prevent substance abuse and reduce demand for illicit narcotics.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/doug-collins/C001093" target="_blank">Rep. Collins, Doug [R-GA-9]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5933/cosponsors?r=51&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Oversight and Government Reform, Judiciary, Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the Committee on Oversight and Government Reform, and in addition to the Committees on the Judiciary, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5933/all-actions?r=51&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        52.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5932?r=52">H.R.5932</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To increase the recruitment and retention of school-based mental health services providers by low-income local educational agencies.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/judy-chu/C001080" target="_blank">Rep. Chu, Judy [D-CA-27]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5932/cosponsors?r=52&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5932/all-actions?r=52&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    52.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5932?r=52">H.R.5932</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To increase the recruitment and retention of school-based mental health services providers by low-income local educational agencies.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/judy-chu/C001080" target="_blank">Rep. Chu, Judy [D-CA-27]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5932/cosponsors?r=52&amp;overview=closed#tabs">2</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5932/all-actions?r=52&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        53.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5931?r=53">H.R.5931</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To repeal the authority to establish certain special volunteer programs under the Domestic Volunteer Service Act.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/andy-biggs/B001302" target="_blank">Rep. Biggs, Andy [R-AZ-5]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5931/cosponsors?r=53&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5931/all-actions?r=53&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    53.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5931?r=53">H.R.5931</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To repeal the authority to establish certain special volunteer programs under the Domestic Volunteer Service Act.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/andy-biggs/B001302" target="_blank">Rep. Biggs, Andy [R-AZ-5]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5931/cosponsors?r=53&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5931/all-actions?r=53&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        54.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5930?r=54">H.R.5930</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To strengthen protections relating to the online collection, use, and disclosure of personal information of children and minors, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/joe-barton/B000213" target="_blank">Rep. Barton, Joe [R-TX-6]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5930/cosponsors?r=54&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5930/all-actions?r=54&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    54.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5930?r=54">H.R.5930</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To strengthen protections relating to the online collection, use, and disclosure of personal information of children and minors, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/joe-barton/B000213" target="_blank">Rep. Barton, Joe [R-TX-6]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5930/cosponsors?r=54&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5930/all-actions?r=54&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        55.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5929?r=55">H.R.5929</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Small Business Act to provide for small business concerns located in the United States Virgin Islands, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/yvette-clarke/C001067" target="_blank">Rep. Clarke, Yvette D. [D-NY-9]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5929/cosponsors?r=55&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Small Business        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Small Business. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5929/all-actions?r=55&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    55.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5929?r=55">H.R.5929</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Small Business Act to provide for small business concerns located in the United States Virgin Islands, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/yvette-clarke/C001067" target="_blank">Rep. Clarke, Yvette D. [D-NY-9]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5929/cosponsors?r=55&amp;overview=closed#tabs">2</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Small Business</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Small Business. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5929/all-actions?r=55&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        56.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5928?r=56">H.R.5928</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To repeal the Tax Cuts and Jobs Act, forgive all outstanding Federal student loans, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/jared-polis/P000598" target="_blank">Rep. Polis, Jared [D-CO-2]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5928/cosponsors?r=56&amp;overview=closed#tabs">14</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Ways and Means, Education and the Workforce, Natural Resources, Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Education and the Workforce, Natural Resources, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5928/all-actions?r=56&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    56.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5928?r=56">H.R.5928</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To repeal the Tax Cuts and Jobs Act, forgive all outstanding Federal student loans, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/jared-polis/P000598" target="_blank">Rep. Polis, Jared [D-CO-2]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5928/cosponsors?r=56&amp;overview=closed#tabs">14</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Ways and Means, Education and the Workforce, Natural Resources, Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Education and the Workforce, Natural Resources, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5928/all-actions?r=56&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        57.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5927?r=57">H.R.5927</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Public Health Service Act to expand, intensify, and coordinate research and other activities of the National Institutes of Health with respect to prenatal opioid exposure and neonatal abstinence syndrome.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/darren-soto/S001200" target="_blank">Rep. Soto, Darren [D-FL-9]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5927/cosponsors?r=57&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5927/all-actions?r=57&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    57.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5927?r=57">H.R.5927</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Public Health Service Act to expand, intensify, and coordinate research and other activities of the National Institutes of Health with respect to prenatal opioid exposure and neonatal abstinence syndrome.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/darren-soto/S001200" target="_blank">Rep. Soto, Darren [D-FL-9]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5927/cosponsors?r=57&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5927/all-actions?r=57&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        58.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5926?r=58">H.R.5926</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To require the Secretary of Health and Human Services to issue guidelines for prescribing naloxone, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/william-keating/K000375" target="_blank">Rep. Keating, William R. [D-MA-9]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5926/cosponsors?r=58&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5926/all-actions?r=58&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    58.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5926?r=58">H.R.5926</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To require the Secretary of Health and Human Services to issue guidelines for prescribing naloxone, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/william-keating/K000375" target="_blank">Rep. Keating, William R. [D-MA-9]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5926/cosponsors?r=58&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5926/all-actions?r=58&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        59.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5925?r=59">H.R.5925</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">CRISIS Act</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/trey-gowdy/G000566" target="_blank">Rep. Gowdy, Trey [R-SC-4]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5925/cosponsors?r=59&amp;overview=closed#tabs">3</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Oversight and Government Reform, Energy and Commerce, Foreign Affairs, Judiciary, Intelligence (Permanent Select), Appropriations        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Ordered to be Reported (Amended) by Voice Vote. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5925/all-actions?r=59&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    59.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5925?r=59">H.R.5925</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">CRISIS Act</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/trey-gowdy/G000566" target="_blank">Rep. Gowdy, Trey [R-SC-4]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5925/cosponsors?r=59&amp;overview=closed#tabs">3</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Oversight and Government Reform, Energy and Commerce, Foreign Affairs, Judiciary, Intelligence (Permanent Select), Appropriations</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Ordered to be Reported (Amended) by Voice Vote. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5925/all-actions?r=59&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        60.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5924?r=60">H.R.5924</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To provide for the consideration of a definition of anti-Semitism for the enforcement of Federal antidiscrimination laws concerning education programs or activities.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/peter-roskam/R000580" target="_blank">Rep. Roskam, Peter J. [R-IL-6]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5924/cosponsors?r=60&amp;overview=closed#tabs">12</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Judiciary, Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5924/all-actions?r=60&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    60.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5924?r=60">H.R.5924</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To provide for the consideration of a definition of anti-Semitism for the enforcement of Federal antidiscrimination laws concerning education programs or activities.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/peter-roskam/R000580" target="_blank">Rep. Roskam, Peter J. [R-IL-6]</a> (Introduced 05/23/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5924/cosponsors?r=60&amp;overview=closed#tabs">12</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Judiciary, Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5924/all-actions?r=60&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-23
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        61.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5923?r=61">H.R.5923</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To direct the Secretary of Agriculture to exchange certain public lands in Ouachita National Forest, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/bruce-westerman/W000821" target="_blank">Rep. Westerman, Bruce [R-AR-4]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5923/cosponsors?r=61&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Natural Resources        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Natural Resources. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5923/all-actions?r=61&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    61.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5923?r=61">H.R.5923</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To direct the Secretary of Agriculture to exchange certain public lands in Ouachita National Forest, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/bruce-westerman/W000821" target="_blank">Rep. Westerman, Bruce [R-AR-4]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5923/cosponsors?r=61&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Natural Resources</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Natural Resources. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5923/all-actions?r=61&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        62.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5922?r=62">H.R.5922</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To direct the Secretary of Veterans Affairs to carry out a pilot program to increase access to hepatitis C testing for Vietnam-era veterans, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/elise-stefanik/S001196" target="_blank">Rep. Stefanik, Elise M. [R-NY-21]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5922/cosponsors?r=62&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Veterans' Affairs        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Veterans' Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5922/all-actions?r=62&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    62.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5922?r=62">H.R.5922</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To direct the Secretary of Veterans Affairs to carry out a pilot program to increase access to hepatitis C testing for Vietnam-era veterans, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/elise-stefanik/S001196" target="_blank">Rep. Stefanik, Elise M. [R-NY-21]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5922/cosponsors?r=62&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Veterans' Affairs</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Veterans' Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5922/all-actions?r=62&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        63.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5921?r=63">H.R.5921</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To direct the Secretary of Veterans Affairs to establish a registry to ensure that members of the Armed Forces who may have been exposed to per- and polyfluoroalkyl substances on military installations receive information regarding such exposure, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/carol-shea-porter/S001170" target="_blank">Rep. Shea-Porter, Carol [D-NH-1]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5921/cosponsors?r=63&amp;overview=closed#tabs">3</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Veterans' Affairs, Armed Services        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5921/all-actions?r=63&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    63.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5921?r=63">H.R.5921</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To direct the Secretary of Veterans Affairs to establish a registry to ensure that members of the Armed Forces who may have been exposed to per- and polyfluoroalkyl substances on military installations receive information regarding such exposure, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/carol-shea-porter/S001170" target="_blank">Rep. Shea-Porter, Carol [D-NH-1]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5921/cosponsors?r=63&amp;overview=closed#tabs">3</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Veterans' Affairs, Armed Services</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5921/all-actions?r=63&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        64.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5920?r=64">H.R.5920</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To direct the Secretary of Veterans Affairs and the Secretary of Defense to submit to Congress an annual report on open burn pits, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/carol-shea-porter/S001170" target="_blank">Rep. Shea-Porter, Carol [D-NH-1]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5920/cosponsors?r=64&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Veterans' Affairs, Armed Services        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5920/all-actions?r=64&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    64.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5920?r=64">H.R.5920</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To direct the Secretary of Veterans Affairs and the Secretary of Defense to submit to Congress an annual report on open burn pits, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/carol-shea-porter/S001170" target="_blank">Rep. Shea-Porter, Carol [D-NH-1]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5920/cosponsors?r=64&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Veterans' Affairs, Armed Services</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5920/all-actions?r=64&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        65.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5919?r=65">H.R.5919</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To establish the position of Senior Anticorruption Officer at the Department of State, the United States Agency for International Development, and the Department of Defense, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/carol-shea-porter/S001170" target="_blank">Rep. Shea-Porter, Carol [D-NH-1]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5919/cosponsors?r=65&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Foreign Affairs, Armed Services        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the Committee on Foreign Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee concerned. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5919/all-actions?r=65&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    65.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5919?r=65">H.R.5919</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To establish the position of Senior Anticorruption Officer at the Department of State, the United States Agency for International Development, and the Department of Defense, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/carol-shea-porter/S001170" target="_blank">Rep. Shea-Porter, Carol [D-NH-1]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5919/cosponsors?r=65&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Foreign Affairs, Armed Services</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the Committee on Foreign Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee concerned. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5919/all-actions?r=65&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        66.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5918?r=66">H.R.5918</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To direct the Secretary of Defense to carry out a program on service dog training for members of the Armed Forces with post-traumatic stress disorder or other post-deployment mental health conditions.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/carol-shea-porter/S001170" target="_blank">Rep. Shea-Porter, Carol [D-NH-1]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5918/cosponsors?r=66&amp;overview=closed#tabs">4</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Armed Services        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Armed Services. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5918/all-actions?r=66&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    66.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5918?r=66">H.R.5918</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To direct the Secretary of Defense to carry out a program on service dog training for members of the Armed Forces with post-traumatic stress disorder or other post-deployment mental health conditions.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/carol-shea-porter/S001170" target="_blank">Rep. Shea-Porter, Carol [D-NH-1]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5918/cosponsors?r=66&amp;overview=closed#tabs">4</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Armed Services</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Armed Services. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5918/all-actions?r=66&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        67.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5917?r=67">H.R.5917</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To authorize the Secretary of Health and Human Services to award grants for career support for skilled, internationally educated health professionals, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/lucille-roybal-allard/R000486" target="_blank">Rep. Roybal-Allard, Lucille [D-CA-40]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5917/cosponsors?r=67&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5917/all-actions?r=67&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    67.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5917?r=67">H.R.5917</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To authorize the Secretary of Health and Human Services to award grants for career support for skilled, internationally educated health professionals, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/lucille-roybal-allard/R000486" target="_blank">Rep. Roybal-Allard, Lucille [D-CA-40]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5917/cosponsors?r=67&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5917/all-actions?r=67&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        68.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5916?r=68">H.R.5916</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Internal Revenue Code of 1986 to impose a tax on institutions of higher education that fail to use 33 percent of the growth in endowment value for grants for working-family students each year, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/tom-reed/R000585" target="_blank">Rep. Reed, Tom [R-NY-23]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5916/cosponsors?r=68&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Ways and Means, Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5916/all-actions?r=68&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    68.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5916?r=68">H.R.5916</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Internal Revenue Code of 1986 to impose a tax on institutions of higher education that fail to use 33 percent of the growth in endowment value for grants for working-family students each year, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/tom-reed/R000585" target="_blank">Rep. Reed, Tom [R-NY-23]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5916/cosponsors?r=68&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Ways and Means, Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5916/all-actions?r=68&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        69.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5915?r=69">H.R.5915</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the TRIO programs to require priority to be given to homeless children and youth, and students in foster care.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/paul-mitchell/M001201" target="_blank">Rep. Mitchell, Paul [R-MI-10]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5915/cosponsors?r=69&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5915/all-actions?r=69&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    69.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5915?r=69">H.R.5915</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the TRIO programs to require priority to be given to homeless children and youth, and students in foster care.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/paul-mitchell/M001201" target="_blank">Rep. Mitchell, Paul [R-MI-10]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5915/cosponsors?r=69&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5915/all-actions?r=69&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        70.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5914?r=70">H.R.5914</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To require a study and report on policy and regulatory changes that may have contributed to the opioid epidemic.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/mark-meadows/M001187" target="_blank">Rep. Meadows, Mark [R-NC-11]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5914/cosponsors?r=70&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5914/all-actions?r=70&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    70.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5914?r=70">H.R.5914</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To require a study and report on policy and regulatory changes that may have contributed to the opioid epidemic.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/mark-meadows/M001187" target="_blank">Rep. Meadows, Mark [R-NC-11]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5914/cosponsors?r=70&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5914/all-actions?r=70&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        71.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5913?r=71">H.R.5913</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Internal Revenue Code of 1986 to increase the limitation on the state and local tax deduction for married individuals, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/thomas-macarthur/M001193" target="_blank">Rep. MacArthur, Thomas [R-NJ-3]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5913/cosponsors?r=71&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Ways and Means        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Ways and Means. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5913/all-actions?r=71&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    71.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5913?r=71">H.R.5913</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Internal Revenue Code of 1986 to increase the limitation on the state and local tax deduction for married individuals, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/thomas-macarthur/M001193" target="_blank">Rep. MacArthur, Thomas [R-NJ-3]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5913/cosponsors?r=71&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Ways and Means</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Ways and Means. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5913/all-actions?r=71&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        72.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5912?r=72">H.R.5912</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend title XIX of the Social Security Act to delay the reduction in Federal medical assistance percentage for Medicaid personal care services and home health services furnished without an electronic visit verification system, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/james-langevin/L000559" target="_blank">Rep. Langevin, James R. [D-RI-2]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5912/cosponsors?r=72&amp;overview=closed#tabs">3</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5912/all-actions?r=72&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    72.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5912?r=72">H.R.5912</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend title XIX of the Social Security Act to delay the reduction in Federal medical assistance percentage for Medicaid personal care services and home health services furnished without an electronic visit verification system, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/james-langevin/L000559" target="_blank">Rep. Langevin, James R. [D-RI-2]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5912/cosponsors?r=72&amp;overview=closed#tabs">3</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5912/all-actions?r=72&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        73.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5911?r=73">H.R.5911</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend Public Law 115-97 (commonly known as the Tax Cuts and Jobs Act) to repeal the Arctic National Wildlife Refuge oil and gas program, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/jared-huffman/H001068" target="_blank">Rep. Huffman, Jared [D-CA-2]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5911/cosponsors?r=73&amp;overview=closed#tabs">4</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Natural Resources        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Natural Resources. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5911/all-actions?r=73&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    73.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5911?r=73">H.R.5911</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend Public Law 115-97 (commonly known as the Tax Cuts and Jobs Act) to repeal the Arctic National Wildlife Refuge oil and gas program, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/jared-huffman/H001068" target="_blank">Rep. Huffman, Jared [D-CA-2]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5911/cosponsors?r=73&amp;overview=closed#tabs">4</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Natural Resources</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Natural Resources. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5911/all-actions?r=73&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        74.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5910?r=74">H.R.5910</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To strengthen the United States response to Russian interference, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/val-demings/D000627" target="_blank">Rep. Demings, Val Butler [D-FL-10]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5910/cosponsors?r=74&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Foreign Affairs, Armed Services, Intelligence (Permanent Select), Oversight and Government Reform, Financial Services        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the Committee on Foreign Affairs, and in addition to the Committees on Armed Services, Intelligence (Permanent Select), Oversight and Government Reform, and Financial Services, for a period to be subsequently determined by the Speaker, in each case for... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5910/all-actions?r=74&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    74.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5910?r=74">H.R.5910</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To strengthen the United States response to Russian interference, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/val-demings/D000627" target="_blank">Rep. Demings, Val Butler [D-FL-10]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5910/cosponsors?r=74&amp;overview=closed#tabs">2</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Foreign Affairs, Armed Services, Intelligence (Permanent Select), Oversight and Government Reform, Financial Services</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the Committee on Foreign Affairs, and in addition to the Committees on Armed Services, Intelligence (Permanent Select), Oversight and Government Reform, and Financial Services, for a period to be subsequently determined by the Speaker, in each case for... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5910/all-actions?r=74&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        75.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5909?r=75">H.R.5909</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To enhance reciprocal market access for United States domestic producers in the negotiating process of bilateral, regional, and multilateral trade agreements.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/rosa-delauro/D000216" target="_blank">Rep. DeLauro, Rosa L. [D-CT-3]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5909/cosponsors?r=75&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Ways and Means        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Ways and Means. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5909/all-actions?r=75&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    75.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5909?r=75">H.R.5909</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To enhance reciprocal market access for United States domestic producers in the negotiating process of bilateral, regional, and multilateral trade agreements.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/rosa-delauro/D000216" target="_blank">Rep. DeLauro, Rosa L. [D-CT-3]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5909/cosponsors?r=75&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Ways and Means</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Ways and Means. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5909/all-actions?r=75&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        76.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5908?r=76">H.R.5908</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To protect victims of crime or serious labor violations from removal during Department of Homeland Security enforcement actions, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/judy-chu/C001080" target="_blank">Rep. Chu, Judy [D-CA-27]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5908/cosponsors?r=76&amp;overview=closed#tabs">6</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Judiciary        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5908/all-actions?r=76&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    76.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5908?r=76">H.R.5908</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To protect victims of crime or serious labor violations from removal during Department of Homeland Security enforcement actions, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/judy-chu/C001080" target="_blank">Rep. Chu, Judy [D-CA-27]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5908/cosponsors?r=76&amp;overview=closed#tabs">6</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Judiciary</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5908/all-actions?r=76&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        77.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5907?r=77">H.R.5907</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To provide directors of the National Laboratories signature authority for certain agreements, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/randy-hultgren/H001059" target="_blank">Rep. Hultgren, Randy [R-IL-14]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5907/cosponsors?r=77&amp;overview=closed#tabs">11</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Science, Space, and Technology        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5907/all-actions?r=77&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    77.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5907?r=77">H.R.5907</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To provide directors of the National Laboratories signature authority for certain agreements, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/randy-hultgren/H001059" target="_blank">Rep. Hultgren, Randy [R-IL-14]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5907/cosponsors?r=77&amp;overview=closed#tabs">11</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Science, Space, and Technology</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5907/all-actions?r=77&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        78.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5906?r=78">H.R.5906</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the America COMPETES Act to establish Department of Energy policy for Advanced Research Projects Agency-Energy, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/frank-lucas/L000491" target="_blank">Rep. Lucas, Frank D. [R-OK-3]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5906/cosponsors?r=78&amp;overview=closed#tabs">9</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Science, Space, and Technology        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5906/all-actions?r=78&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    78.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5906?r=78">H.R.5906</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the America COMPETES Act to establish Department of Energy policy for Advanced Research Projects Agency-Energy, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/frank-lucas/L000491" target="_blank">Rep. Lucas, Frank D. [R-OK-3]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5906/cosponsors?r=78&amp;overview=closed#tabs">9</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Science, Space, and Technology</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5906/all-actions?r=78&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        79.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5905?r=79">H.R.5905</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To authorize basic research programs in the Department of Energy Office of Science for fiscal years 2018 and 2019.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/randy-weber/W000814" target="_blank">Rep. Weber, Randy K., Sr. [R-TX-14]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5905/cosponsors?r=79&amp;overview=closed#tabs">11</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Science, Space, and Technology        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5905/all-actions?r=79&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    79.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5905?r=79">H.R.5905</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To authorize basic research programs in the Department of Energy Office of Science for fiscal years 2018 and 2019.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/randy-weber/W000814" target="_blank">Rep. Weber, Randy K., Sr. [R-TX-14]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5905/cosponsors?r=79&amp;overview=closed#tabs">11</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Science, Space, and Technology</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5905/all-actions?r=79&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        80.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5904?r=80">H.R.5904</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Sherman Act to make oil-producing and exporting cartels illegal.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/steve-chabot/C000266" target="_blank">Rep. Chabot, Steve [R-OH-1]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5904/cosponsors?r=80&amp;overview=closed#tabs">5</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Judiciary        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5904/all-actions?r=80&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    80.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5904?r=80">H.R.5904</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Sherman Act to make oil-producing and exporting cartels illegal.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/steve-chabot/C000266" target="_blank">Rep. Chabot, Steve [R-OH-1]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5904/cosponsors?r=80&amp;overview=closed#tabs">5</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Judiciary</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5904/all-actions?r=80&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        81.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5903?r=81">H.R.5903</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Internal Revenue Code of 1986 to make permanent certain changes made by Public Law 115-97 to the child tax credit.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/jason-smith/S001195" target="_blank">Rep. Smith, Jason [R-MO-8]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5903/cosponsors?r=81&amp;overview=closed#tabs">12</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Ways and Means        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/22/2018 Referred to the House Committee on Ways and Means. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5903/all-actions?r=81&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    81.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5903?r=81">H.R.5903</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Internal Revenue Code of 1986 to make permanent certain changes made by Public Law 115-97 to the child tax credit.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/jason-smith/S001195" target="_blank">Rep. Smith, Jason [R-MO-8]</a> (Introduced 05/22/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5903/cosponsors?r=81&amp;overview=closed#tabs">12</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Ways and Means</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/22/2018 Referred to the House Committee on Ways and Means. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5903/all-actions?r=81&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-22
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        82.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5902?r=82">H.R.5902</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Ethics in Government Act of 1978 to provide for reform in the operations of the Office of Government Ethics, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/jamie-raskin/R000606" target="_blank">Rep. Raskin, Jamie [D-MD-8]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5902/cosponsors?r=82&amp;overview=closed#tabs">22</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Oversight and Government Reform, Judiciary        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Referred to the Committee on Oversight and Government Reform, and in addition to the Committee on the Judiciary, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5902/all-actions?r=82&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    82.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5902?r=82">H.R.5902</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Ethics in Government Act of 1978 to provide for reform in the operations of the Office of Government Ethics, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/jamie-raskin/R000606" target="_blank">Rep. Raskin, Jamie [D-MD-8]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5902/cosponsors?r=82&amp;overview=closed#tabs">22</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Oversight and Government Reform, Judiciary</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Referred to the Committee on Oversight and Government Reform, and in addition to the Committee on the Judiciary, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5902/all-actions?r=82&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        83.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5901?r=83">H.R.5901</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend title 10, United States Code, to permit the Secretary of the Army to produce, treat, manage, and use natural gas located under Fort Knox, Kentucky, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/brett-guthrie/G000558" target="_blank">Rep. Guthrie, Brett [R-KY-2]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5901/cosponsors?r=83&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Armed Services        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Referred to the House Committee on Armed Services. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5901/all-actions?r=83&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    83.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5901?r=83">H.R.5901</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend title 10, United States Code, to permit the Secretary of the Army to produce, treat, manage, and use natural gas located under Fort Knox, Kentucky, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/brett-guthrie/G000558" target="_blank">Rep. Guthrie, Brett [R-KY-2]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5901/cosponsors?r=83&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Armed Services</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Referred to the House Committee on Armed Services. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5901/all-actions?r=83&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        84.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5900?r=84">H.R.5900</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To provide for a national strategy to address and overcome Lyme disease and other tick-borne diseases, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/christopher-smith/S000522" target="_blank">Rep. Smith, Christopher H. [R-NJ-4]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5900/cosponsors?r=84&amp;overview=closed#tabs">6</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5900/all-actions?r=84&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    84.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5900?r=84">H.R.5900</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To provide for a national strategy to address and overcome Lyme disease and other tick-borne diseases, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/christopher-smith/S000522" target="_blank">Rep. Smith, Christopher H. [R-NJ-4]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5900/cosponsors?r=84&amp;overview=closed#tabs">6</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5900/all-actions?r=84&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        85.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5899?r=85">H.R.5899</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Public Health Service Act to reauthorize school-based health centers, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/john-faso/F000464" target="_blank">Rep. Faso, John J. [R-NY-19]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5899/cosponsors?r=85&amp;overview=closed#tabs">4</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5899/all-actions?r=85&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    85.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5899?r=85">H.R.5899</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Public Health Service Act to reauthorize school-based health centers, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/john-faso/F000464" target="_blank">Rep. Faso, John J. [R-NY-19]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5899/cosponsors?r=85&amp;overview=closed#tabs">4</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5899/all-actions?r=85&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        86.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5898?r=86">H.R.5898</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To require the Secretary of State to develop a strategy on administration policy regarding UNRWA, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/david-cicilline/C001084" target="_blank">Rep. Cicilline, David N. [D-RI-1]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5898/cosponsors?r=86&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Foreign Affairs        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Referred to the House Committee on Foreign Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5898/all-actions?r=86&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    86.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5898?r=86">H.R.5898</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To require the Secretary of State to develop a strategy on administration policy regarding UNRWA, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/david-cicilline/C001084" target="_blank">Rep. Cicilline, David N. [D-RI-1]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5898/cosponsors?r=86&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Foreign Affairs</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Referred to the House Committee on Foreign Affairs. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5898/all-actions?r=86&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        87.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5897?r=87">H.R.5897</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To require the Secretary of the Army to expedite the completion of certain feasibility studies and reports and to amend the Coastal Barrier Resources Act to ensure public safety, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/randy-weber/W000814" target="_blank">Rep. Weber, Randy K., Sr. [R-TX-14]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5897/cosponsors?r=87&amp;overview=closed#tabs">20</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Transportation and Infrastructure, Natural Resources        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Referred to the Committee on Transportation and Infrastructure, and in addition to the Committee on Natural Resources, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5897/all-actions?r=87&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    87.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5897?r=87">H.R.5897</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To require the Secretary of the Army to expedite the completion of certain feasibility studies and reports and to amend the Coastal Barrier Resources Act to ensure public safety, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/randy-weber/W000814" target="_blank">Rep. Weber, Randy K., Sr. [R-TX-14]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5897/cosponsors?r=87&amp;overview=closed#tabs">20</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Transportation and Infrastructure, Natural Resources</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Referred to the Committee on Transportation and Infrastructure, and in addition to the Committee on Natural Resources, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5897/all-actions?r=87&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        88.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5896?r=88">H.R.5896</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend title 5, United States Code, to modify the authority for pay and work schedules of border patrol agents, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/will-hurd/H001073" target="_blank">Rep. Hurd, Will [R-TX-23]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5896/cosponsors?r=88&amp;overview=closed#tabs">3</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Oversight and Government Reform        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/23/2018 Ordered to be Reported (Amended) by Voice Vote. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5896/all-actions?r=88&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    88.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5896?r=88">H.R.5896</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend title 5, United States Code, to modify the authority for pay and work schedules of border patrol agents, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/will-hurd/H001073" target="_blank">Rep. Hurd, Will [R-TX-23]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5896/cosponsors?r=88&amp;overview=closed#tabs">3</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Oversight and Government Reform</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/23/2018 Ordered to be Reported (Amended) by Voice Vote. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5896/all-actions?r=88&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        89.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5895?r=89">H.R.5895</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">Energy and Water Development and Related Agencies Appropriations Act, 2019</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/michael-simpson/S001148" target="_blank">Rep. Simpson, Michael K. [R-ID-2]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5895/cosponsors?r=89&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Appropriations        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Placed on the Union Calendar, Calendar No. 540. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5895/all-actions?r=89&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; The House Committee on Appropriations reported an original measure, H. Rept. 115-697, by Mr. Simpson.
        [externalActionCode] =&gt; 5000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    89.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5895?r=89">H.R.5895</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">Energy and Water Development and Related Agencies Appropriations Act, 2019</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/michael-simpson/S001148" target="_blank">Rep. Simpson, Michael K. [R-ID-2]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5895/cosponsors?r=89&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Appropriations</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Placed on the Union Calendar, Calendar No. 540. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5895/all-actions?r=89&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; The House Committee on Appropriations reported an original measure, H. Rept. 115-697, by Mr. Simpson.
        [externalActionCode] =&gt; 5000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        90.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5894?r=90">H.R.5894</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">Legislative Branch Appropriations Act, 2019</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/kevin-yoder/Y000063" target="_blank">Rep. Yoder, Kevin [R-KS-3]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5894/cosponsors?r=90&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Appropriations        </span>
    <span class="result-item">
    <strong>Committee Reports:</strong> <a href="/congressional-report/115th-congress/house-report/696/1" target="_blank">H. Rept. 115-696</a> </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Placed on the Union Calendar, Calendar No. 539. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5894/all-actions?r=90&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; The House Committee on Appropriations reported an original measure, H. Rept. 115-696, by Mr. Yoder.
        [externalActionCode] =&gt; 5000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    90.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5894?r=90">H.R.5894</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">Legislative Branch Appropriations Act, 2019</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/kevin-yoder/Y000063" target="_blank">Rep. Yoder, Kevin [R-KS-3]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5894/cosponsors?r=90&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Appropriations</span>
    </span>
    <span class="result-item">
    <strong>Committee Reports:</strong>
    <span><a href="/congressional-report/115th-congress/house-report/696/1" target="_blank">H. Rept. 115-696</a></span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Placed on the Union Calendar, Calendar No. 539. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5894/all-actions?r=90&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; The House Committee on Appropriations reported an original measure, H. Rept. 115-696, by Mr. Yoder.
        [externalActionCode] =&gt; 5000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        91.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5893?r=91">H.R.5893</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To require a certain percentage of liquefied natural gas and crude oil exports be transported on United States-built and United States-flag vessels, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/john-garamendi/G000559" target="_blank">Rep. Garamendi, John [D-CA-3]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5893/cosponsors?r=91&amp;overview=closed#tabs">3</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce, Foreign Affairs        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committee on Foreign Affairs, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5893/all-actions?r=91&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    91.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5893?r=91">H.R.5893</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To require a certain percentage of liquefied natural gas and crude oil exports be transported on United States-built and United States-flag vessels, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/john-garamendi/G000559" target="_blank">Rep. Garamendi, John [D-CA-3]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5893/cosponsors?r=91&amp;overview=closed#tabs">3</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Energy and Commerce, Foreign Affairs</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committee on Foreign Affairs, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5893/all-actions?r=91&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        92.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5892?r=92">H.R.5892</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To establish an Advisory Committee on Opioids and the Workplace to advise the Secretary of Labor on actions the Department of Labor can take to address the impact of opioid abuse on the workplace.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/jason-lewis/L000587" target="_blank">Rep. Lewis, Jason [R-MN-2]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5892/cosponsors?r=92&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5892/all-actions?r=92&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    92.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5892?r=92">H.R.5892</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To establish an Advisory Committee on Opioids and the Workplace to advise the Secretary of Labor on actions the Department of Labor can take to address the impact of opioid abuse on the workplace.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/jason-lewis/L000587" target="_blank">Rep. Lewis, Jason [R-MN-2]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5892/cosponsors?r=92&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5892/all-actions?r=92&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        93.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5891?r=93">H.R.5891</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To establish an interagency task force to improve the Federal response to families impacted by substance abuse disorders.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/glenn-grothman/G000576" target="_blank">Rep. Grothman, Glenn [R-WI-6]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5891/cosponsors?r=93&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5891/all-actions?r=93&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    93.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5891?r=93">H.R.5891</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To establish an interagency task force to improve the Federal response to families impacted by substance abuse disorders.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/glenn-grothman/G000576" target="_blank">Rep. Grothman, Glenn [R-WI-6]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5891/cosponsors?r=93&amp;overview=closed#tabs">2</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5891/all-actions?r=93&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        94.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5890?r=94">H.R.5890</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To require the Secretary of Health and Human Services to provide assistance to States in complying with, and implementing, certain provisions of section 106 of the Child Abuse Prevention and Treatment Act in order to promote better protections for young children and family-centered responses, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/thomas-garrett/G000580" target="_blank">Rep. Garrett, Thomas A., Jr. [R-VA-5]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5890/cosponsors?r=94&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5890/all-actions?r=94&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    94.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5890?r=94">H.R.5890</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To require the Secretary of Health and Human Services to provide assistance to States in complying with, and implementing, certain provisions of section 106 of the Child Abuse Prevention and Treatment Act in order to promote better protections for young children and family-centered responses, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/thomas-garrett/G000580" target="_blank">Rep. Garrett, Thomas A., Jr. [R-VA-5]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5890/cosponsors?r=94&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5890/all-actions?r=94&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        95.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5889?r=95">H.R.5889</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To require the Secretary of Health and Human Services to disseminate information, resources, and if requested, technical assistance to early childhood care and education providers and professionals working with young children on ways to properly recognize and respond to children who may be impacted by trauma related to substance abuse.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/dave-brat/B001290" target="_blank">Rep. Brat, Dave [R-VA-7]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5889/cosponsors?r=95&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5889/all-actions?r=95&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    95.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5889?r=95">H.R.5889</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To require the Secretary of Health and Human Services to disseminate information, resources, and if requested, technical assistance to early childhood care and education providers and professionals working with young children on ways to properly recognize and respond to children who may be impacted by trauma related to substance abuse.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/dave-brat/B001290" target="_blank">Rep. Brat, Dave [R-VA-7]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5889/cosponsors?r=95&amp;overview=closed#tabs">2</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5889/all-actions?r=95&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        96.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5888?r=96">H.R.5888</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend part A of title IV of the Social Security Act to provide grants for coordination of the TANF program with career pathways.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/richard-neal/N000015" target="_blank">Rep. Neal, Richard E. [D-MA-1]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5888/cosponsors?r=96&amp;overview=closed#tabs">14</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Ways and Means, Education and the Workforce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5888/all-actions?r=96&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    96.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5888?r=96">H.R.5888</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend part A of title IV of the Social Security Act to provide grants for coordination of the TANF program with career pathways.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/richard-neal/N000015" target="_blank">Rep. Neal, Richard E. [D-MA-1]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5888/cosponsors?r=96&amp;overview=closed#tabs">14</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Ways and Means, Education and the Workforce</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5888/all-actions?r=96&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        97.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5887?r=97">H.R.5887</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Leahy-Smith America Invents Act to extend the period during which the Under Secretary of Commerce for Intellectual Property and Director of the United States Patent and Trademark Office may set or adjust certain fees, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/steve-chabot/C000266" target="_blank">Rep. Chabot, Steve [R-OH-1]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5887/cosponsors?r=97&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Judiciary        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/21/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5887/all-actions?r=97&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    97.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5887?r=97">H.R.5887</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend the Leahy-Smith America Invents Act to extend the period during which the Under Secretary of Commerce for Intellectual Property and Director of the United States Patent and Trademark Office may set or adjust certain fees, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/steve-chabot/C000266" target="_blank">Rep. Chabot, Steve [R-OH-1]</a> (Introduced 05/21/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5887/cosponsors?r=97&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Judiciary</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/21/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5887/all-actions?r=97&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-21
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        98.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5886?r=98">H.R.5886</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To apply the Bank Secrecy Act to dealers in art or antiquities.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/luke-messer/M001189" target="_blank">Rep. Messer, Luke [R-IN-6]</a> (Introduced 05/18/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5886/cosponsors?r=98&amp;overview=closed#tabs">0</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Financial Services        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/18/2018 Referred to the House Committee on Financial Services. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5886/all-actions?r=98&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-18
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    98.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5886?r=98">H.R.5886</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To apply the Bank Secrecy Act to dealers in art or antiquities.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/luke-messer/M001189" target="_blank">Rep. Messer, Luke [R-IN-6]</a> (Introduced 05/18/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5886/cosponsors?r=98&amp;overview=closed#tabs">0</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Financial Services</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/18/2018 Referred to the House Committee on Financial Services. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5886/all-actions?r=98&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-18
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        99.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5885?r=99">H.R.5885</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To reauthorize the Partners for Fish and Wildlife Program and certain wildlife conservation funds, to establish prize competitions relating to the prevention of wildlife poaching and trafficking, wildlife conservation, the management of invasive species, and the protection of endangered species, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/alan-lowenthal/L000579" target="_blank">Rep. Lowenthal, Alan S. [D-CA-47]</a> (Introduced 05/18/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5885/cosponsors?r=99&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Natural Resources, Science, Space, and Technology        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/18/2018 Referred to the Committee on Natural Resources, and in addition to the Committee on Science, Space, and Technology, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5885/all-actions?r=99&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-18
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    99.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5885?r=99">H.R.5885</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To reauthorize the Partners for Fish and Wildlife Program and certain wildlife conservation funds, to establish prize competitions relating to the prevention of wildlife poaching and trafficking, wildlife conservation, the management of invasive species, and the protection of endangered species, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/alan-lowenthal/L000579" target="_blank">Rep. Lowenthal, Alan S. [D-CA-47]</a> (Introduced 05/18/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5885/cosponsors?r=99&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Natural Resources, Science, Space, and Technology</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/18/2018 Referred to the Committee on Natural Resources, and in addition to the Committee on Science, Space, and Technology, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5885/all-actions?r=99&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-18
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li><li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        100.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5884?r=100">H.R.5884</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend title 18, United States Code, to punish unlawful obstruction of the enforcement of the laws of the United States by State officials, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/steve-king/K000362" target="_blank">Rep. King, Steve [R-IA-4]</a> (Introduced 05/18/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5884/cosponsors?r=100&amp;overview=closed#tabs">1</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Judiciary        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/18/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5884/all-actions?r=100&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-18
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>
    <li class="compact" style="display:none;">    100.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5884?r=100">H.R.5884</a> — 115th Congress (2017-2018)</span>
    <span class="result-title bottom-padding">To amend title 18, United States Code, to punish unlawful obstruction of the enforcement of the laws of the United States by State officials, and for other purposes.</span>
    <span class="result-item">
    <strong>Sponsor:</strong>
    <span><a href="/member/steve-king/K000362" target="_blank">Rep. King, Steve [R-IA-4]</a> (Introduced 05/18/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5884/cosponsors?r=100&amp;overview=closed#tabs">1</a>)</span>
    </span>
    <span class="result-item">
    <strong>Committees:</strong>
    <span>House - Judiciary</span>
    </span>
    <span class="result-item">
    <strong>Latest Action:</strong>
    <span>House - 05/18/2018 Referred to the House Committee on the Judiciary. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5884/all-actions?r=100&amp;overview=closed#tabs">All Actions</a>)</span>
    </span>
    <span class="result-item result-tracker">
    <strong>Tracker:</strong>
    <span><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-18
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol></span>
    </span>
    </li></ol>




```python
for child in ordered.children:
    print(child.text)
```

     BILL
        1.
        H.R.5983 — 115th Congress (2017-2018)
    To amend the Communications Act of 1934 to require providers of a covered service to provide location information concerning the telecommunications device of a user of such service to an investigative or law enforcement officer or an employee or other agent of a public safety answering point in an emergency situation involving risk of death or serious physical harm or in order to respond to the user's call for emergency services.
    
    Sponsor: Rep. Yoder, Kevin [R-KS-3] (Introduced 05/25/2018) Cosponsors: (2)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    



    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    <ipython-input-98-446feabf88a0> in <module>()
          1 for child in ordered.children:
    ----> 2     print(child.text)
    

    ~\AppData\Local\Continuum\Anaconda3\lib\site-packages\bs4\element.py in __getattr__(self, attr)
        735             raise AttributeError(
        736                 "'%s' object has no attribute '%s'" % (
    --> 737                     self.__class__.__name__, attr))
        738 
        739     def output_ready(self, formatter="minimal"):


    AttributeError: 'NavigableString' object has no attribute 'text'


What about the error?

### Debugging the error

Looking at the element that causes the error in the loop:


```python
child
```




    '\n'



Problem: not all children are list items (`<li>`)

Possible solutions:
 - Catch the error
 - use `find_all('li')`.
     - Possible problem: if there are more list items deeper in the hierarchy, you may accidentally pull them into the results. We want "`<li>` tags that are direct children of the element set to `ordered`"

**Using `find_all`**

Note that the Passed House, Passed Senate, etc. statuses are treated as their own elements


```python
for child in ordered.find_all('li'):
    print("===================")
    print(child.text)
```

    ===================
     BILL
        1.
        H.R.5983 — 115th Congress (2017-2018)
    To amend the Communications Act of 1934 to require providers of a covered service to provide location information concerning the telecommunications device of a user of such service to an investigative or law enforcement officer or an employee or other agent of a public safety answering point in an emergency situation involving risk of death or serious physical harm or in order to respond to the user's call for emergency services.
    
    Sponsor: Rep. Yoder, Kevin [R-KS-3] (Introduced 05/25/2018) Cosponsors: (2)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        1.
        H.R.5983 — 115th Congress (2017-2018)
    To amend the Communications Act of 1934 to require providers of a covered service to provide location information concerning the telecommunications device of a user of such service to an investigative or law enforcement officer or an employee or other agent of a public safety answering point in an emergency situation involving risk of death or serious physical harm or in order to respond to the user's call for emergency services.
    
    Sponsor:
    Rep. Yoder, Kevin [R-KS-3] (Introduced 05/25/2018) Cosponsors: (2)
    
    
    Committees:
    House - Energy and Commerce
    
    
    Latest Action:
    House - 05/25/2018 Referred to the House Committee on Energy and Commerce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        2.
        H.R.5982 — 115th Congress (2017-2018)
    To amend title 5, United States Code, to increase the gratuity owed upon death of an employee in connection with the employee's service with an Armed Force, to limit the amount of any death gratuity paid upon the death of a Member of Congress, and for other purposes.
    
    Sponsor: Rep. Walorski, Jackie [R-IN-2] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Education and the Workforce, House Administration        
     Latest Action:             House - 05/25/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on House Administration, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        2.
        H.R.5982 — 115th Congress (2017-2018)
    To amend title 5, United States Code, to increase the gratuity owed upon death of an employee in connection with the employee's service with an Armed Force, to limit the amount of any death gratuity paid upon the death of a Member of Congress, and for other purposes.
    
    Sponsor:
    Rep. Walorski, Jackie [R-IN-2] (Introduced 05/25/2018) Cosponsors: (0)
    
    
    Committees:
    House - Education and the Workforce, House Administration
    
    
    Latest Action:
    House - 05/25/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on House Administration, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        3.
        H.R.5981 — 115th Congress (2017-2018)
    To amend title 44, United States Code, to prohibit the Archivist from charging certain fees to veterans for destroyed records regarding such veterans, and for other purposes.
    
    Sponsor: Rep. Smith, Christopher H. [R-NJ-4] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        3.
        H.R.5981 — 115th Congress (2017-2018)
    To amend title 44, United States Code, to prohibit the Archivist from charging certain fees to veterans for destroyed records regarding such veterans, and for other purposes.
    
    Sponsor:
    Rep. Smith, Christopher H. [R-NJ-4] (Introduced 05/25/2018) Cosponsors: (0)
    
    
    Committees:
    House - Oversight and Government Reform
    
    
    Latest Action:
    House - 05/25/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        4.
        H.R.5980 — 115th Congress (2017-2018)
    To authorize, develop, and implement a coordinated tracking system of federally-funded initiatives and grant programs for substance abuse treatment, prevention, and enforcement, and for other purposes.
    
    Sponsor: Rep. Rothfus, Keith J. [R-PA-12] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        4.
        H.R.5980 — 115th Congress (2017-2018)
    To authorize, develop, and implement a coordinated tracking system of federally-funded initiatives and grant programs for substance abuse treatment, prevention, and enforcement, and for other purposes.
    
    Sponsor:
    Rep. Rothfus, Keith J. [R-PA-12] (Introduced 05/25/2018) Cosponsors: (0)
    
    
    Committees:
    House - Oversight and Government Reform
    
    
    Latest Action:
    House - 05/25/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        5.
        H.R.5979 — 115th Congress (2017-2018)
    To establish the Mill Springs Battlefield National Monument in the State of Kentucky as a unit of the National Park System, and for other purposes.
    
    Sponsor: Rep. Rogers, Harold [R-KY-5] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Natural Resources        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Natural Resources. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        5.
        H.R.5979 — 115th Congress (2017-2018)
    To establish the Mill Springs Battlefield National Monument in the State of Kentucky as a unit of the National Park System, and for other purposes.
    
    Sponsor:
    Rep. Rogers, Harold [R-KY-5] (Introduced 05/25/2018) Cosponsors: (0)
    
    
    Committees:
    House - Natural Resources
    
    
    Latest Action:
    House - 05/25/2018 Referred to the House Committee on Natural Resources. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        6.
        H.R.5978 — 115th Congress (2017-2018)
    To amend the Food Security Act of 1985 to provide for certain payment limitations with respect to commodity programs, and for other purposes.
    
    Sponsor: Rep. Meadows, Mark [R-NC-11] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Agriculture        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Agriculture. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        6.
        H.R.5978 — 115th Congress (2017-2018)
    To amend the Food Security Act of 1985 to provide for certain payment limitations with respect to commodity programs, and for other purposes.
    
    Sponsor:
    Rep. Meadows, Mark [R-NC-11] (Introduced 05/25/2018) Cosponsors: (0)
    
    
    Committees:
    House - Agriculture
    
    
    Latest Action:
    House - 05/25/2018 Referred to the House Committee on Agriculture. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        7.
        H.R.5977 — 115th Congress (2017-2018)
    To improve Federal efforts with respect to the prevention of maternal mortality, and for other purposes.
    
    Sponsor: Rep. Kelly, Robin L. [D-IL-2] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        7.
        H.R.5977 — 115th Congress (2017-2018)
    To improve Federal efforts with respect to the prevention of maternal mortality, and for other purposes.
    
    Sponsor:
    Rep. Kelly, Robin L. [D-IL-2] (Introduced 05/25/2018) Cosponsors: (0)
    
    
    Committees:
    House - Energy and Commerce
    
    
    Latest Action:
    House - 05/25/2018 Referred to the House Committee on Energy and Commerce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        8.
        H.R.5976 — 115th Congress (2017-2018)
    To amend the Individuals with Disabilities Education Act to direct the Secretary to provide additional funds to States to establish and make disbursements from high cost funds.
    
    Sponsor: Rep. Huffman, Jared [D-CA-2] (Introduced 05/25/2018) Cosponsors: (2)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        8.
        H.R.5976 — 115th Congress (2017-2018)
    To amend the Individuals with Disabilities Education Act to direct the Secretary to provide additional funds to States to establish and make disbursements from high cost funds.
    
    Sponsor:
    Rep. Huffman, Jared [D-CA-2] (Introduced 05/25/2018) Cosponsors: (2)
    
    
    Committees:
    House - Education and the Workforce
    
    
    Latest Action:
    House - 05/25/2018 Referred to the House Committee on Education and the Workforce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        9.
        H.R.5975 — 115th Congress (2017-2018)
    To support businesses in Puerto Rico, extend child tax credits for families in Puerto Rico, and for other purposes.
    
    Sponsor: Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large] (Introduced 05/25/2018) Cosponsors: (5)        
    
    Committees: House - Ways and Means, Small Business, Financial Services, Oversight and Government Reform, Energy and Commerce        
     Latest Action:             House - 05/25/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Small Business, Financial Services, Oversight and Government Reform, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        9.
        H.R.5975 — 115th Congress (2017-2018)
    To support businesses in Puerto Rico, extend child tax credits for families in Puerto Rico, and for other purposes.
    
    Sponsor:
    Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large] (Introduced 05/25/2018) Cosponsors: (5)
    
    
    Committees:
    House - Ways and Means, Small Business, Financial Services, Oversight and Government Reform, Energy and Commerce
    
    
    Latest Action:
    House - 05/25/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Small Business, Financial Services, Oversight and Government Reform, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        10.
        H.R.5974 — 115th Congress (2017-2018)
    To direct the Secretary of Veterans Affairs to use on-site regulated medical waste treatment systems at certain Department of Veterans Affairs facilities, and for other purposes.
    
    Sponsor: Rep. Denham, Jeff [R-CA-10] (Introduced 05/25/2018) Cosponsors: (3)        
    
    Committees: House - Veterans' Affairs        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Veterans' Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        10.
        H.R.5974 — 115th Congress (2017-2018)
    To direct the Secretary of Veterans Affairs to use on-site regulated medical waste treatment systems at certain Department of Veterans Affairs facilities, and for other purposes.
    
    Sponsor:
    Rep. Denham, Jeff [R-CA-10] (Introduced 05/25/2018) Cosponsors: (3)
    
    
    Committees:
    House - Veterans' Affairs
    
    
    Latest Action:
    House - 05/25/2018 Referred to the House Committee on Veterans' Affairs. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        11.
        H.R.5973 — 115th Congress (2017-2018)
    To amend the Robert T. Stafford Disaster Relief and Emergency Assistance Act to require a report on risk transfer, and for other purposes.
    
    Sponsor: Rep. Ross, Dennis A. [R-FL-15] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Transportation and Infrastructure        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Transportation and Infrastructure. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        11.
        H.R.5973 — 115th Congress (2017-2018)
    To amend the Robert T. Stafford Disaster Relief and Emergency Assistance Act to require a report on risk transfer, and for other purposes.
    
    Sponsor:
    Rep. Ross, Dennis A. [R-FL-15] (Introduced 05/25/2018) Cosponsors: (0)
    
    
    Committees:
    House - Transportation and Infrastructure
    
    
    Latest Action:
    House - 05/25/2018 Referred to the House Committee on Transportation and Infrastructure. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        12.
        H.R.5972 — 115th Congress (2017-2018)
    To amend section 502 of title 40, United States Code, to allow State and local governments to purchase from the Federal supply schedule, and for other purposes.
    
    Sponsor: Rep. Zeldin, Lee M. [R-NY-1] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        12.
        H.R.5972 — 115th Congress (2017-2018)
    To amend section 502 of title 40, United States Code, to allow State and local governments to purchase from the Federal supply schedule, and for other purposes.
    
    Sponsor:
    Rep. Zeldin, Lee M. [R-NY-1] (Introduced 05/24/2018) Cosponsors: (1)
    
    
    Committees:
    House - Oversight and Government Reform
    
    
    Latest Action:
    House - 05/24/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        13.
        H.R.5971 — 115th Congress (2017-2018)
    To include nonprofit and volunteer ground and air ambulance crew members and first responders for certain benefits.
    
    Sponsor: Rep. Zeldin, Lee M. [R-NY-1] (Introduced 05/24/2018) Cosponsors: (0)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        13.
        H.R.5971 — 115th Congress (2017-2018)
    To include nonprofit and volunteer ground and air ambulance crew members and first responders for certain benefits.
    
    Sponsor:
    Rep. Zeldin, Lee M. [R-NY-1] (Introduced 05/24/2018) Cosponsors: (0)
    
    
    Committees:
    House - Judiciary
    
    
    Latest Action:
    House - 05/24/2018 Referred to the House Committee on the Judiciary. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        14.
        H.R.5970 — 115th Congress (2017-2018)
    To require the Securities and Exchange Commission to implement rules simplifying the quarterly financial reporting regime.
    
    Sponsor: Rep. Wagner, Ann [R-MO-2] (Introduced 05/24/2018) Cosponsors: (0)        
    
    Committees: House - Financial Services        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Financial Services. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        14.
        H.R.5970 — 115th Congress (2017-2018)
    To require the Securities and Exchange Commission to implement rules simplifying the quarterly financial reporting regime.
    
    Sponsor:
    Rep. Wagner, Ann [R-MO-2] (Introduced 05/24/2018) Cosponsors: (0)
    
    
    Committees:
    House - Financial Services
    
    
    Latest Action:
    House - 05/24/2018 Referred to the House Committee on Financial Services. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        15.
        H.R.5969 — 115th Congress (2017-2018)
    To prohibit the use of Federal funds for the provision of broadband service in any State that has in effect a law, regulation, or other requirement that prohibits, limits, places conditions on, or regulates the provision of broadband service by public, cooperative, or nonprofit broadband providers.
    
    Sponsor: Rep. Pocan, Mark [D-WI-2] (Introduced 05/24/2018) Cosponsors: (0)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        15.
        H.R.5969 — 115th Congress (2017-2018)
    To prohibit the use of Federal funds for the provision of broadband service in any State that has in effect a law, regulation, or other requirement that prohibits, limits, places conditions on, or regulates the provision of broadband service by public, cooperative, or nonprofit broadband providers.
    
    Sponsor:
    Rep. Pocan, Mark [D-WI-2] (Introduced 05/24/2018) Cosponsors: (0)
    
    
    Committees:
    House - Energy and Commerce
    
    
    Latest Action:
    House - 05/24/2018 Referred to the House Committee on Energy and Commerce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        16.
        H.R.5968 — 115th Congress (2017-2018)
    To encourage online workforce training.
    
    Sponsor: Rep. Larsen, Rick [D-WA-2] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        16.
        H.R.5968 — 115th Congress (2017-2018)
    To encourage online workforce training.
    
    Sponsor:
    Rep. Larsen, Rick [D-WA-2] (Introduced 05/24/2018) Cosponsors: (1)
    
    
    Committees:
    House - Education and the Workforce
    
    
    Latest Action:
    House - 05/24/2018 Referred to the House Committee on Education and the Workforce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        17.
        H.R.5967 — 115th Congress (2017-2018)
    To establish a single export promotion agency in the executive branch, and for other purposes.
    
    Sponsor: Rep. Kuster, Ann M. [D-NH-2] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Foreign Affairs        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Foreign Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        17.
        H.R.5967 — 115th Congress (2017-2018)
    To establish a single export promotion agency in the executive branch, and for other purposes.
    
    Sponsor:
    Rep. Kuster, Ann M. [D-NH-2] (Introduced 05/24/2018) Cosponsors: (1)
    
    
    Committees:
    House - Foreign Affairs
    
    
    Latest Action:
    House - 05/24/2018 Referred to the House Committee on Foreign Affairs. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        18.
        H.R.5966 — 115th Congress (2017-2018)
    To improve the provision of health care for women veterans by the Department of Veterans Affairs, and for other purposes.
    
    Sponsor: Rep. Keating, William R. [D-MA-9] (Introduced 05/24/2018) Cosponsors: (3)        
    
    Committees: House - Veterans' Affairs        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Veterans' Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        18.
        H.R.5966 — 115th Congress (2017-2018)
    To improve the provision of health care for women veterans by the Department of Veterans Affairs, and for other purposes.
    
    Sponsor:
    Rep. Keating, William R. [D-MA-9] (Introduced 05/24/2018) Cosponsors: (3)
    
    
    Committees:
    House - Veterans' Affairs
    
    
    Latest Action:
    House - 05/24/2018 Referred to the House Committee on Veterans' Affairs. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        19.
        H.R.5965 — 115th Congress (2017-2018)
    To require health insurance coverage for the treatment of infertility.
    
    Sponsor: Rep. DeLauro, Rosa L. [D-CT-3] (Introduced 05/24/2018) Cosponsors: (0)        
    
    Committees: House - Energy and Commerce, Oversight and Government Reform, Armed Services, Veterans' Affairs        
     Latest Action:             House - 05/24/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committees on Oversight and Government Reform, Armed Services, and Veterans' Affairs, for a period to be subsequently determined by the Speaker, in each case for consideration of such... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        19.
        H.R.5965 — 115th Congress (2017-2018)
    To require health insurance coverage for the treatment of infertility.
    
    Sponsor:
    Rep. DeLauro, Rosa L. [D-CT-3] (Introduced 05/24/2018) Cosponsors: (0)
    
    
    Committees:
    House - Energy and Commerce, Oversight and Government Reform, Armed Services, Veterans' Affairs
    
    
    Latest Action:
    House - 05/24/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committees on Oversight and Government Reform, Armed Services, and Veterans' Affairs, for a period to be subsequently determined by the Speaker, in each case for consideration of such... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        20.
        H.R.5964 — 115th Congress (2017-2018)
    To amend the Professional Boxing Safety Act of 1996 to provide additional safety standards for professional boxing.
    
    Sponsor: Rep. Cartwright, Matt [D-PA-17] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Education and the Workforce, Energy and Commerce        
     Latest Action:             House - 05/24/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        20.
        H.R.5964 — 115th Congress (2017-2018)
    To amend the Professional Boxing Safety Act of 1996 to provide additional safety standards for professional boxing.
    
    Sponsor:
    Rep. Cartwright, Matt [D-PA-17] (Introduced 05/24/2018) Cosponsors: (1)
    
    
    Committees:
    House - Education and the Workforce, Energy and Commerce
    
    
    Latest Action:
    House - 05/24/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        21.
        H.R.5963 — 115th Congress (2017-2018)
    To delay the reimposition of the annual fee on health insurance providers until after 2020.
    
    Sponsor: Rep. Noem, Kristi L. [R-SD-At Large] (Introduced 05/24/2018) Cosponsors: (3)        
    
    Committees: House - Ways and Means, Energy and Commerce        
     Latest Action:             House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        21.
        H.R.5963 — 115th Congress (2017-2018)
    To delay the reimposition of the annual fee on health insurance providers until after 2020.
    
    Sponsor:
    Rep. Noem, Kristi L. [R-SD-At Large] (Introduced 05/24/2018) Cosponsors: (3)
    
    
    Committees:
    House - Ways and Means, Energy and Commerce
    
    
    Latest Action:
    House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        22.
        H.R.5962 — 115th Congress (2017-2018)
    To provide for loan forgiveness for STEM teachers, and for other purposes.
    
    Sponsor: Rep. Swalwell, Eric [D-CA-15] (Introduced 05/24/2018) Cosponsors: (4)        
    
    Committees: House - Ways and Means, Education and the Workforce        
     Latest Action:             House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        22.
        H.R.5962 — 115th Congress (2017-2018)
    To provide for loan forgiveness for STEM teachers, and for other purposes.
    
    Sponsor:
    Rep. Swalwell, Eric [D-CA-15] (Introduced 05/24/2018) Cosponsors: (4)
    
    
    Committees:
    House - Ways and Means, Education and the Workforce
    
    
    Latest Action:
    House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        23.
        H.R.5961 — 115th Congress (2017-2018)
    Making appropriations for Agriculture, Rural Development, Food and Drug Administration, and Related Agencies programs for the fiscal year ending September 30, 2019, and for other purposes.
    
    Sponsor: Rep. Aderholt, Robert B. [R-AL-4] (Introduced 05/24/2018) Cosponsors: (0)        
    
    Committees: House - Appropriations        
    
    Committee Reports: H. Rept. 115-706 
     Latest Action:             House - 05/24/2018 Placed on the Union Calendar, Calendar No. 545. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-706, by Mr. Aderholt.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-706, by Mr. Aderholt.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        23.
        H.R.5961 — 115th Congress (2017-2018)
    Making appropriations for Agriculture, Rural Development, Food and Drug Administration, and Related Agencies programs for the fiscal year ending September 30, 2019, and for other purposes.
    
    Sponsor:
    Rep. Aderholt, Robert B. [R-AL-4] (Introduced 05/24/2018) Cosponsors: (0)
    
    
    Committees:
    House - Appropriations
    
    
    Committee Reports:
    H. Rept. 115-706
    
    
    Latest Action:
    House - 05/24/2018 Placed on the Union Calendar, Calendar No. 545. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-706, by Mr. Aderholt.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-706, by Mr. Aderholt.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        24.
        H.R.5960 — 115th Congress (2017-2018)
    To direct the Attorney General to make grants to regional gang task forces to prevent violence committed by and against youths, and for other purposes.
    
    Sponsor: Rep. Connolly, Gerald E. [D-VA-11] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        24.
        H.R.5960 — 115th Congress (2017-2018)
    To direct the Attorney General to make grants to regional gang task forces to prevent violence committed by and against youths, and for other purposes.
    
    Sponsor:
    Rep. Connolly, Gerald E. [D-VA-11] (Introduced 05/24/2018) Cosponsors: (1)
    
    
    Committees:
    House - Judiciary
    
    
    Latest Action:
    House - 05/24/2018 Referred to the House Committee on the Judiciary. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        25.
        H.R.5959 — 115th Congress (2017-2018)
    To promote national security and jobs through the use of natural gas to fuel heavy-duty trucks and fleet vehicles.
    
    Sponsor: Rep. Mullin, Markwayne [R-OK-2] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Ways and Means, Oversight and Government Reform, Energy and Commerce, Science, Space, and Technology        
     Latest Action:             House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Oversight and Government Reform, Energy and Commerce, and Science, Space, and Technology, for a period to be subsequently determined by the Speaker, in each case for consideration of... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        25.
        H.R.5959 — 115th Congress (2017-2018)
    To promote national security and jobs through the use of natural gas to fuel heavy-duty trucks and fleet vehicles.
    
    Sponsor:
    Rep. Mullin, Markwayne [R-OK-2] (Introduced 05/24/2018) Cosponsors: (1)
    
    
    Committees:
    House - Ways and Means, Oversight and Government Reform, Energy and Commerce, Science, Space, and Technology
    
    
    Latest Action:
    House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Oversight and Government Reform, Energy and Commerce, and Science, Space, and Technology, for a period to be subsequently determined by the Speaker, in each case for consideration of... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        26.
        H.R.5958 — 115th Congress (2017-2018)
    To amend title XVIII of the Social Security Act to require pharmacy-negotiated price concessions and pharmacy incentive payments and adjustments to be included in negotiated prices at the point-of-sale under part D of the Medicare program, and for other purposes.
    
    Sponsor: Rep. Collins, Doug [R-GA-9] (Introduced 05/24/2018) Cosponsors: (3)        
    
    Committees: House - Energy and Commerce, Ways and Means        
     Latest Action:             House - 05/24/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committee on Ways and Means, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        26.
        H.R.5958 — 115th Congress (2017-2018)
    To amend title XVIII of the Social Security Act to require pharmacy-negotiated price concessions and pharmacy incentive payments and adjustments to be included in negotiated prices at the point-of-sale under part D of the Medicare program, and for other purposes.
    
    Sponsor:
    Rep. Collins, Doug [R-GA-9] (Introduced 05/24/2018) Cosponsors: (3)
    
    
    Committees:
    House - Energy and Commerce, Ways and Means
    
    
    Latest Action:
    House - 05/24/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committee on Ways and Means, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        27.
        H.R.5957 — 115th Congress (2017-2018)
    To establish the Caddo Lake National Heritage Area, and for other purposes.
    
    Sponsor: Rep. Gohmert, Louie [R-TX-1] (Introduced 05/24/2018) Cosponsors: (2)        
    
    Committees: House - Natural Resources        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Natural Resources. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        27.
        H.R.5957 — 115th Congress (2017-2018)
    To establish the Caddo Lake National Heritage Area, and for other purposes.
    
    Sponsor:
    Rep. Gohmert, Louie [R-TX-1] (Introduced 05/24/2018) Cosponsors: (2)
    
    
    Committees:
    House - Natural Resources
    
    
    Latest Action:
    House - 05/24/2018 Referred to the House Committee on Natural Resources. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        28.
        H.R.5956 — 115th Congress (2017-2018)
    To incentivize the hiring of United States workers in the Commonwealth of the Northern Mariana Islands, and for other purposes.
    
    Sponsor: Rep. Bishop, Rob [R-UT-1] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Natural Resources        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Natural Resources. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        28.
        H.R.5956 — 115th Congress (2017-2018)
    To incentivize the hiring of United States workers in the Commonwealth of the Northern Mariana Islands, and for other purposes.
    
    Sponsor:
    Rep. Bishop, Rob [R-UT-1] (Introduced 05/24/2018) Cosponsors: (1)
    
    
    Committees:
    House - Natural Resources
    
    
    Latest Action:
    House - 05/24/2018 Referred to the House Committee on Natural Resources. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        29.
        H.R.5955 — 115th Congress (2017-2018)
    To reauthorize subtitle A of the Victims of Child Abuse Act of 1990.
    
    Sponsor: Rep. Poe, Ted [R-TX-2] (Introduced 05/24/2018) Cosponsors: (13)        
    
    Committees: House - Judiciary, Education and the Workforce        
     Latest Action:             House - 05/24/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        29.
        H.R.5955 — 115th Congress (2017-2018)
    To reauthorize subtitle A of the Victims of Child Abuse Act of 1990.
    
    Sponsor:
    Rep. Poe, Ted [R-TX-2] (Introduced 05/24/2018) Cosponsors: (13)
    
    
    Committees:
    House - Judiciary, Education and the Workforce
    
    
    Latest Action:
    House - 05/24/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        30.
        H.R.5954 — 115th Congress (2017-2018)
    To amend title 18, United States Code, to clarify the meaning of the terms "act of war" and "blocked asset", and for other purposes.
    
    Sponsor: Rep. Goodlatte, Bob [R-VA-6] (Introduced 05/24/2018) Cosponsors: (4)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        30.
        H.R.5954 — 115th Congress (2017-2018)
    To amend title 18, United States Code, to clarify the meaning of the terms "act of war" and "blocked asset", and for other purposes.
    
    Sponsor:
    Rep. Goodlatte, Bob [R-VA-6] (Introduced 05/24/2018) Cosponsors: (4)
    
    
    Committees:
    House - Judiciary
    
    
    Latest Action:
    House - 05/24/2018 Referred to the House Committee on the Judiciary. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        31.
        H.R.5953 — 115th Congress (2017-2018)
    To provide regulatory relief to charitable organizations that provide housing assistance, and for other purposes.
    
    Sponsor: Rep. Loudermilk, Barry [R-GA-11] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Financial Services        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Financial Services. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        31.
        H.R.5953 — 115th Congress (2017-2018)
    To provide regulatory relief to charitable organizations that provide housing assistance, and for other purposes.
    
    Sponsor:
    Rep. Loudermilk, Barry [R-GA-11] (Introduced 05/24/2018) Cosponsors: (1)
    
    
    Committees:
    House - Financial Services
    
    
    Latest Action:
    House - 05/24/2018 Referred to the House Committee on Financial Services. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        32.
        H.R.5952 — 115th Congress (2017-2018)
    Science Appropriations Act, 2019
    
    Sponsor: Rep. Culberson, John Abney [R-TX-7] (Introduced 05/24/2018) Cosponsors: (0)        
    
    Committees: House - Appropriations        
    
    Committee Reports: H. Rept. 115-704 
     Latest Action:             House - 05/24/2018 Placed on the Union Calendar, Calendar No. 544. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-704, by Mr. Culberson.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-704, by Mr. Culberson.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        32.
        H.R.5952 — 115th Congress (2017-2018)
    Science Appropriations Act, 2019
    
    Sponsor:
    Rep. Culberson, John Abney [R-TX-7] (Introduced 05/24/2018) Cosponsors: (0)
    
    
    Committees:
    House - Appropriations
    
    
    Committee Reports:
    H. Rept. 115-704
    
    
    Latest Action:
    House - 05/24/2018 Placed on the Union Calendar, Calendar No. 544. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-704, by Mr. Culberson.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-704, by Mr. Culberson.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        33.
        H.R.5951 — 115th Congress (2017-2018)
    To establish the Veterans Crisis Response Corps, and for other purposes.
    
    Sponsor: Rep. Schiff, Adam B. [D-CA-28] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Veterans' Affairs, Transportation and Infrastructure, Foreign Affairs, Armed Services        
     Latest Action:             House - 05/23/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committees on Transportation and Infrastructure, Foreign Affairs, and Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        33.
        H.R.5951 — 115th Congress (2017-2018)
    To establish the Veterans Crisis Response Corps, and for other purposes.
    
    Sponsor:
    Rep. Schiff, Adam B. [D-CA-28] (Introduced 05/23/2018) Cosponsors: (2)
    
    
    Committees:
    House - Veterans' Affairs, Transportation and Infrastructure, Foreign Affairs, Armed Services
    
    
    Latest Action:
    House - 05/23/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committees on Transportation and Infrastructure, Foreign Affairs, and Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        34.
        H.R.5950 — 115th Congress (2017-2018)
    To protect children affected by immigration enforcement actions.
    
    Sponsor: Rep. Roybal-Allard, Lucille [D-CA-40] (Introduced 05/23/2018) Cosponsors: (6)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        34.
        H.R.5950 — 115th Congress (2017-2018)
    To protect children affected by immigration enforcement actions.
    
    Sponsor:
    Rep. Roybal-Allard, Lucille [D-CA-40] (Introduced 05/23/2018) Cosponsors: (6)
    
    
    Committees:
    House - Judiciary
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on the Judiciary. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        35.
        H.R.5949 — 115th Congress (2017-2018)
    To exempt certain motor carriers engaged in agricultural business from the electronic logging device requirements, and for other purposes.
    
    Sponsor: Rep. Peterson, Collin C. [D-MN-7] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Transportation and Infrastructure        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Transportation and Infrastructure. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        35.
        H.R.5949 — 115th Congress (2017-2018)
    To exempt certain motor carriers engaged in agricultural business from the electronic logging device requirements, and for other purposes.
    
    Sponsor:
    Rep. Peterson, Collin C. [D-MN-7] (Introduced 05/23/2018) Cosponsors: (2)
    
    
    Committees:
    House - Transportation and Infrastructure
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Transportation and Infrastructure. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        36.
        H.R.5948 — 115th Congress (2017-2018)
    To exempt motor carriers that own or operate 10 or fewer commercial vehicles from the electronic logging device mandates, and for other purposes.
    
    Sponsor: Rep. Peterson, Collin C. [D-MN-7] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Transportation and Infrastructure        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Transportation and Infrastructure. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        36.
        H.R.5948 — 115th Congress (2017-2018)
    To exempt motor carriers that own or operate 10 or fewer commercial vehicles from the electronic logging device mandates, and for other purposes.
    
    Sponsor:
    Rep. Peterson, Collin C. [D-MN-7] (Introduced 05/23/2018) Cosponsors: (2)
    
    
    Committees:
    House - Transportation and Infrastructure
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Transportation and Infrastructure. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        37.
        H.R.5947 — 115th Congress (2017-2018)
    To repeal the Asia Foundation Act, and for other purposes.
    
    Sponsor: Rep. Norman, Ralph [R-SC-5] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Foreign Affairs        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Foreign Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        37.
        H.R.5947 — 115th Congress (2017-2018)
    To repeal the Asia Foundation Act, and for other purposes.
    
    Sponsor:
    Rep. Norman, Ralph [R-SC-5] (Introduced 05/23/2018) Cosponsors: (0)
    
    
    Committees:
    House - Foreign Affairs
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Foreign Affairs. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        38.
        H.R.5946 — 115th Congress (2017-2018)
    To provide that Members of Congress shall not be paid if Congress has not approved a concurrent resolution on the budget and passed the regular appropriations bills on a timely basis, to eliminate automatic pay adjustments for Members of Congress, to prohibit the use of funds provided for the official travel expenses of Members of Congress and other officers and employees of the legislative branch for first-class airline accommodations, to establish a lifetime ban on lobbying by former Members of Congress, to prohibit consideration in the House of Representatives of measures lacking demonstrable bipartisan support, and for other purposes.
    
    Sponsor: Rep. Murphy, Stephanie N. [D-FL-7] (Introduced 05/23/2018) Cosponsors: (1)        
    
    Committees: House - House Administration, Oversight and Government Reform, Judiciary, Rules        
     Latest Action:             House - 05/23/2018 Referred to the Committee on House Administration, and in addition to the Committees on Oversight and Government Reform, the Judiciary, and Rules, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        38.
        H.R.5946 — 115th Congress (2017-2018)
    To provide that Members of Congress shall not be paid if Congress has not approved a concurrent resolution on the budget and passed the regular appropriations bills on a timely basis, to eliminate automatic pay adjustments for Members of Congress, to prohibit the use of funds provided for the official travel expenses of Members of Congress and other officers and employees of the legislative branch for first-class airline accommodations, to establish a lifetime ban on lobbying by former Members of Congress, to prohibit consideration in the House of Representatives of measures lacking demonstrable bipartisan support, and for other purposes.
    
    Sponsor:
    Rep. Murphy, Stephanie N. [D-FL-7] (Introduced 05/23/2018) Cosponsors: (1)
    
    
    Committees:
    House - House Administration, Oversight and Government Reform, Judiciary, Rules
    
    
    Latest Action:
    House - 05/23/2018 Referred to the Committee on House Administration, and in addition to the Committees on Oversight and Government Reform, the Judiciary, and Rules, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        39.
        H.R.5945 — 115th Congress (2017-2018)
    To encourage, enhance, and integrate Green Alert plans throughout the United States, and for other purposes.
    
    Sponsor: Rep. Moore, Gwen [D-WI-4] (Introduced 05/23/2018) Cosponsors: (8)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        39.
        H.R.5945 — 115th Congress (2017-2018)
    To encourage, enhance, and integrate Green Alert plans throughout the United States, and for other purposes.
    
    Sponsor:
    Rep. Moore, Gwen [D-WI-4] (Introduced 05/23/2018) Cosponsors: (8)
    
    
    Committees:
    House - Judiciary
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on the Judiciary. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        40.
        H.R.5944 — 115th Congress (2017-2018)
    To improve career and technical education by providing improved educational opportunities and financial assistance for career and technical educators.
    
    Sponsor: Rep. Maloney, Sean Patrick [D-NY-18] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        40.
        H.R.5944 — 115th Congress (2017-2018)
    To improve career and technical education by providing improved educational opportunities and financial assistance for career and technical educators.
    
    Sponsor:
    Rep. Maloney, Sean Patrick [D-NY-18] (Introduced 05/23/2018) Cosponsors: (0)
    
    
    Committees:
    House - Education and the Workforce
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        41.
        H.R.5943 — 115th Congress (2017-2018)
    To amend the Carl D. Perkins Career and Technical Education Act of 2006 to improve professional development for career and technical educators.
    
    Sponsor: Rep. Maloney, Sean Patrick [D-NY-18] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        41.
        H.R.5943 — 115th Congress (2017-2018)
    To amend the Carl D. Perkins Career and Technical Education Act of 2006 to improve professional development for career and technical educators.
    
    Sponsor:
    Rep. Maloney, Sean Patrick [D-NY-18] (Introduced 05/23/2018) Cosponsors: (0)
    
    
    Committees:
    House - Education and the Workforce
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        42.
        H.R.5942 — 115th Congress (2017-2018)
    To improve the health of minority individuals, and for other purposes.
    
    Sponsor: Rep. Lee, Barbara [D-CA-13] (Introduced 05/23/2018) Cosponsors: (57)        
    
    Committees: House - Energy and Commerce, Ways and Means, Agriculture, Education and the Workforce, Budget, Judiciary, Veterans' Affairs, Armed Services, Natural Resources        
     Latest Action:             House - 05/23/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committees on Ways and Means, Agriculture, Education and the Workforce, the Budget, the Judiciary, Veterans' Affairs, Armed Services, and Natural Resources, for a period to be subsequently... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        42.
        H.R.5942 — 115th Congress (2017-2018)
    To improve the health of minority individuals, and for other purposes.
    
    Sponsor:
    Rep. Lee, Barbara [D-CA-13] (Introduced 05/23/2018) Cosponsors: (57)
    
    
    Committees:
    House - Energy and Commerce, Ways and Means, Agriculture, Education and the Workforce, Budget, Judiciary, Veterans' Affairs, Armed Services, Natural Resources
    
    
    Latest Action:
    House - 05/23/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committees on Ways and Means, Agriculture, Education and the Workforce, the Budget, the Judiciary, Veterans' Affairs, Armed Services, and Natural Resources, for a period to be subsequently... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        43.
        H.R.5941 — 115th Congress (2017-2018)
    To prevent child injuries and deaths by firearms.
    
    Sponsor: Rep. Langevin, James R. [D-RI-2] (Introduced 05/23/2018) Cosponsors: (3)        
    
    Committees: House - Judiciary, Energy and Commerce        
     Latest Action:             House - 05/23/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        43.
        H.R.5941 — 115th Congress (2017-2018)
    To prevent child injuries and deaths by firearms.
    
    Sponsor:
    Rep. Langevin, James R. [D-RI-2] (Introduced 05/23/2018) Cosponsors: (3)
    
    
    Committees:
    House - Judiciary, Energy and Commerce
    
    
    Latest Action:
    House - 05/23/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        44.
        H.R.5940 — 115th Congress (2017-2018)
    To require the Secretary of Defense to submit to Congress a report on victims in military criminal investigative organization reports, and for other purposes.
    
    Sponsor: Rep. Kuster, Ann M. [D-NH-2] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Armed Services        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Armed Services. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        44.
        H.R.5940 — 115th Congress (2017-2018)
    To require the Secretary of Defense to submit to Congress a report on victims in military criminal investigative organization reports, and for other purposes.
    
    Sponsor:
    Rep. Kuster, Ann M. [D-NH-2] (Introduced 05/23/2018) Cosponsors: (2)
    
    
    Committees:
    House - Armed Services
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Armed Services. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        45.
        H.R.5939 — 115th Congress (2017-2018)
    To amend the Morris K. Udall and Stewart L. Udall Foundation Act.
    
    Sponsor: Rep. Grijalva, Raul M. [D-AZ-3] (Introduced 05/23/2018) Cosponsors: (1)        
    
    Committees: House - Education and the Workforce, Natural Resources        
     Latest Action:             House - 05/23/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on Natural Resources, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        45.
        H.R.5939 — 115th Congress (2017-2018)
    To amend the Morris K. Udall and Stewart L. Udall Foundation Act.
    
    Sponsor:
    Rep. Grijalva, Raul M. [D-AZ-3] (Introduced 05/23/2018) Cosponsors: (1)
    
    
    Committees:
    House - Education and the Workforce, Natural Resources
    
    
    Latest Action:
    House - 05/23/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on Natural Resources, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        46.
        H.R.5938 — 115th Congress (2017-2018)
    To amend the VA Choice and Quality Employment Act to direct the Secretary of Veterans Affairs to establish a vacancy and recruitment database to facilitate the recruitment of certain members of the Armed Forces to satisfy the occupational needs of the Department of Veterans Affairs, to establish and implement a training and certification program for intermediate care technicians in that Department, and for other purposes.
    
    Sponsor: Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Veterans' Affairs        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Veterans' Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        46.
        H.R.5938 — 115th Congress (2017-2018)
    To amend the VA Choice and Quality Employment Act to direct the Secretary of Veterans Affairs to establish a vacancy and recruitment database to facilitate the recruitment of certain members of the Armed Forces to satisfy the occupational needs of the Department of Veterans Affairs, to establish and implement a training and certification program for intermediate care technicians in that Department, and for other purposes.
    
    Sponsor:
    Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large] (Introduced 05/23/2018) Cosponsors: (0)
    
    
    Committees:
    House - Veterans' Affairs
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Veterans' Affairs. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        47.
        H.R.5937 — 115th Congress (2017-2018)
    To designate the facility of the United States Postal Service located at 100 Calle Alondra in San Juan, Puerto Rico, as the "65th Infantry Regiment Post Office Building".
    
    Sponsor: Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        47.
        H.R.5937 — 115th Congress (2017-2018)
    To designate the facility of the United States Postal Service located at 100 Calle Alondra in San Juan, Puerto Rico, as the "65th Infantry Regiment Post Office Building".
    
    Sponsor:
    Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large] (Introduced 05/23/2018) Cosponsors: (0)
    
    
    Committees:
    House - Oversight and Government Reform
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        48.
        H.R.5936 — 115th Congress (2017-2018)
    To amend the National Security Act of 1947 to require the appointment by the President of the Assistant to the President for National Security Affairs to be made by and with the advice and consent of the Senate.
    
    Sponsor: Rep. Foster, Bill [D-IL-11] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Armed Services, Foreign Affairs, Intelligence (Permanent Select)        
     Latest Action:             House - 05/23/2018 Referred to the Committee on Armed Services, and in addition to the Committees on Foreign Affairs, and Intelligence (Permanent Select), for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        48.
        H.R.5936 — 115th Congress (2017-2018)
    To amend the National Security Act of 1947 to require the appointment by the President of the Assistant to the President for National Security Affairs to be made by and with the advice and consent of the Senate.
    
    Sponsor:
    Rep. Foster, Bill [D-IL-11] (Introduced 05/23/2018) Cosponsors: (2)
    
    
    Committees:
    House - Armed Services, Foreign Affairs, Intelligence (Permanent Select)
    
    
    Latest Action:
    House - 05/23/2018 Referred to the Committee on Armed Services, and in addition to the Committees on Foreign Affairs, and Intelligence (Permanent Select), for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        49.
        H.R.5935 — 115th Congress (2017-2018)
    To designate the facility of the United States Postal Service located at 1355 North Meridian Road in Harristown, Illinois, as the "Logan S. Palmer Post Office".
    
    Sponsor: Rep. Davis, Rodney [R-IL-13] (Introduced 05/23/2018) Cosponsors: (17)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        49.
        H.R.5935 — 115th Congress (2017-2018)
    To designate the facility of the United States Postal Service located at 1355 North Meridian Road in Harristown, Illinois, as the "Logan S. Palmer Post Office".
    
    Sponsor:
    Rep. Davis, Rodney [R-IL-13] (Introduced 05/23/2018) Cosponsors: (17)
    
    
    Committees:
    House - Oversight and Government Reform
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        50.
        H.R.5934 — 115th Congress (2017-2018)
    To designate the facility of the United States Postal Service located at 105 Highway 297 North in Dyess, Arkansas, as the "Johnny Cash Post Office Building".
    
    Sponsor: Rep. Crawford, Eric A. "Rick" [R-AR-1] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        50.
        H.R.5934 — 115th Congress (2017-2018)
    To designate the facility of the United States Postal Service located at 105 Highway 297 North in Dyess, Arkansas, as the "Johnny Cash Post Office Building".
    
    Sponsor:
    Rep. Crawford, Eric A. "Rick" [R-AR-1] (Introduced 05/23/2018) Cosponsors: (0)
    
    
    Committees:
    House - Oversight and Government Reform
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        51.
        H.R.5933 — 115th Congress (2017-2018)
    To prevent substance abuse and reduce demand for illicit narcotics.
    
    Sponsor: Rep. Collins, Doug [R-GA-9] (Introduced 05/23/2018) Cosponsors: (1)        
    
    Committees: House - Oversight and Government Reform, Judiciary, Energy and Commerce        
     Latest Action:             House - 05/23/2018 Referred to the Committee on Oversight and Government Reform, and in addition to the Committees on the Judiciary, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        51.
        H.R.5933 — 115th Congress (2017-2018)
    To prevent substance abuse and reduce demand for illicit narcotics.
    
    Sponsor:
    Rep. Collins, Doug [R-GA-9] (Introduced 05/23/2018) Cosponsors: (1)
    
    
    Committees:
    House - Oversight and Government Reform, Judiciary, Energy and Commerce
    
    
    Latest Action:
    House - 05/23/2018 Referred to the Committee on Oversight and Government Reform, and in addition to the Committees on the Judiciary, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        52.
        H.R.5932 — 115th Congress (2017-2018)
    To increase the recruitment and retention of school-based mental health services providers by low-income local educational agencies.
    
    Sponsor: Rep. Chu, Judy [D-CA-27] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        52.
        H.R.5932 — 115th Congress (2017-2018)
    To increase the recruitment and retention of school-based mental health services providers by low-income local educational agencies.
    
    Sponsor:
    Rep. Chu, Judy [D-CA-27] (Introduced 05/23/2018) Cosponsors: (2)
    
    
    Committees:
    House - Education and the Workforce
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        53.
        H.R.5931 — 115th Congress (2017-2018)
    To repeal the authority to establish certain special volunteer programs under the Domestic Volunteer Service Act.
    
    Sponsor: Rep. Biggs, Andy [R-AZ-5] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        53.
        H.R.5931 — 115th Congress (2017-2018)
    To repeal the authority to establish certain special volunteer programs under the Domestic Volunteer Service Act.
    
    Sponsor:
    Rep. Biggs, Andy [R-AZ-5] (Introduced 05/23/2018) Cosponsors: (0)
    
    
    Committees:
    House - Education and the Workforce
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        54.
        H.R.5930 — 115th Congress (2017-2018)
    To strengthen protections relating to the online collection, use, and disclosure of personal information of children and minors, and for other purposes.
    
    Sponsor: Rep. Barton, Joe [R-TX-6] (Introduced 05/23/2018) Cosponsors: (1)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        54.
        H.R.5930 — 115th Congress (2017-2018)
    To strengthen protections relating to the online collection, use, and disclosure of personal information of children and minors, and for other purposes.
    
    Sponsor:
    Rep. Barton, Joe [R-TX-6] (Introduced 05/23/2018) Cosponsors: (1)
    
    
    Committees:
    House - Energy and Commerce
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        55.
        H.R.5929 — 115th Congress (2017-2018)
    To amend the Small Business Act to provide for small business concerns located in the United States Virgin Islands, and for other purposes.
    
    Sponsor: Rep. Clarke, Yvette D. [D-NY-9] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Small Business        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Small Business. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        55.
        H.R.5929 — 115th Congress (2017-2018)
    To amend the Small Business Act to provide for small business concerns located in the United States Virgin Islands, and for other purposes.
    
    Sponsor:
    Rep. Clarke, Yvette D. [D-NY-9] (Introduced 05/23/2018) Cosponsors: (2)
    
    
    Committees:
    House - Small Business
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Small Business. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        56.
        H.R.5928 — 115th Congress (2017-2018)
    To repeal the Tax Cuts and Jobs Act, forgive all outstanding Federal student loans, and for other purposes.
    
    Sponsor: Rep. Polis, Jared [D-CO-2] (Introduced 05/23/2018) Cosponsors: (14)        
    
    Committees: House - Ways and Means, Education and the Workforce, Natural Resources, Energy and Commerce        
     Latest Action:             House - 05/23/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Education and the Workforce, Natural Resources, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        56.
        H.R.5928 — 115th Congress (2017-2018)
    To repeal the Tax Cuts and Jobs Act, forgive all outstanding Federal student loans, and for other purposes.
    
    Sponsor:
    Rep. Polis, Jared [D-CO-2] (Introduced 05/23/2018) Cosponsors: (14)
    
    
    Committees:
    House - Ways and Means, Education and the Workforce, Natural Resources, Energy and Commerce
    
    
    Latest Action:
    House - 05/23/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Education and the Workforce, Natural Resources, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        57.
        H.R.5927 — 115th Congress (2017-2018)
    To amend the Public Health Service Act to expand, intensify, and coordinate research and other activities of the National Institutes of Health with respect to prenatal opioid exposure and neonatal abstinence syndrome.
    
    Sponsor: Rep. Soto, Darren [D-FL-9] (Introduced 05/23/2018) Cosponsors: (1)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        57.
        H.R.5927 — 115th Congress (2017-2018)
    To amend the Public Health Service Act to expand, intensify, and coordinate research and other activities of the National Institutes of Health with respect to prenatal opioid exposure and neonatal abstinence syndrome.
    
    Sponsor:
    Rep. Soto, Darren [D-FL-9] (Introduced 05/23/2018) Cosponsors: (1)
    
    
    Committees:
    House - Energy and Commerce
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        58.
        H.R.5926 — 115th Congress (2017-2018)
    To require the Secretary of Health and Human Services to issue guidelines for prescribing naloxone, and for other purposes.
    
    Sponsor: Rep. Keating, William R. [D-MA-9] (Introduced 05/23/2018) Cosponsors: (1)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        58.
        H.R.5926 — 115th Congress (2017-2018)
    To require the Secretary of Health and Human Services to issue guidelines for prescribing naloxone, and for other purposes.
    
    Sponsor:
    Rep. Keating, William R. [D-MA-9] (Introduced 05/23/2018) Cosponsors: (1)
    
    
    Committees:
    House - Energy and Commerce
    
    
    Latest Action:
    House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        59.
        H.R.5925 — 115th Congress (2017-2018)
    CRISIS Act
    
    Sponsor: Rep. Gowdy, Trey [R-SC-4] (Introduced 05/23/2018) Cosponsors: (3)        
    
    Committees: House - Oversight and Government Reform, Energy and Commerce, Foreign Affairs, Judiciary, Intelligence (Permanent Select), Appropriations        
     Latest Action:             House - 05/23/2018 Ordered to be Reported (Amended) by Voice Vote. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        59.
        H.R.5925 — 115th Congress (2017-2018)
    CRISIS Act
    
    Sponsor:
    Rep. Gowdy, Trey [R-SC-4] (Introduced 05/23/2018) Cosponsors: (3)
    
    
    Committees:
    House - Oversight and Government Reform, Energy and Commerce, Foreign Affairs, Judiciary, Intelligence (Permanent Select), Appropriations
    
    
    Latest Action:
    House - 05/23/2018 Ordered to be Reported (Amended) by Voice Vote. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        60.
        H.R.5924 — 115th Congress (2017-2018)
    To provide for the consideration of a definition of anti-Semitism for the enforcement of Federal antidiscrimination laws concerning education programs or activities.
    
    Sponsor: Rep. Roskam, Peter J. [R-IL-6] (Introduced 05/23/2018) Cosponsors: (12)        
    
    Committees: House - Judiciary, Education and the Workforce        
     Latest Action:             House - 05/23/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        60.
        H.R.5924 — 115th Congress (2017-2018)
    To provide for the consideration of a definition of anti-Semitism for the enforcement of Federal antidiscrimination laws concerning education programs or activities.
    
    Sponsor:
    Rep. Roskam, Peter J. [R-IL-6] (Introduced 05/23/2018) Cosponsors: (12)
    
    
    Committees:
    House - Judiciary, Education and the Workforce
    
    
    Latest Action:
    House - 05/23/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        61.
        H.R.5923 — 115th Congress (2017-2018)
    To direct the Secretary of Agriculture to exchange certain public lands in Ouachita National Forest, and for other purposes.
    
    Sponsor: Rep. Westerman, Bruce [R-AR-4] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Natural Resources        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Natural Resources. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        61.
        H.R.5923 — 115th Congress (2017-2018)
    To direct the Secretary of Agriculture to exchange certain public lands in Ouachita National Forest, and for other purposes.
    
    Sponsor:
    Rep. Westerman, Bruce [R-AR-4] (Introduced 05/22/2018) Cosponsors: (0)
    
    
    Committees:
    House - Natural Resources
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Natural Resources. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        62.
        H.R.5922 — 115th Congress (2017-2018)
    To direct the Secretary of Veterans Affairs to carry out a pilot program to increase access to hepatitis C testing for Vietnam-era veterans, and for other purposes.
    
    Sponsor: Rep. Stefanik, Elise M. [R-NY-21] (Introduced 05/22/2018) Cosponsors: (1)        
    
    Committees: House - Veterans' Affairs        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Veterans' Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        62.
        H.R.5922 — 115th Congress (2017-2018)
    To direct the Secretary of Veterans Affairs to carry out a pilot program to increase access to hepatitis C testing for Vietnam-era veterans, and for other purposes.
    
    Sponsor:
    Rep. Stefanik, Elise M. [R-NY-21] (Introduced 05/22/2018) Cosponsors: (1)
    
    
    Committees:
    House - Veterans' Affairs
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Veterans' Affairs. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        63.
        H.R.5921 — 115th Congress (2017-2018)
    To direct the Secretary of Veterans Affairs to establish a registry to ensure that members of the Armed Forces who may have been exposed to per- and polyfluoroalkyl substances on military installations receive information regarding such exposure, and for other purposes.
    
    Sponsor: Rep. Shea-Porter, Carol [D-NH-1] (Introduced 05/22/2018) Cosponsors: (3)        
    
    Committees: House - Veterans' Affairs, Armed Services        
     Latest Action:             House - 05/22/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        63.
        H.R.5921 — 115th Congress (2017-2018)
    To direct the Secretary of Veterans Affairs to establish a registry to ensure that members of the Armed Forces who may have been exposed to per- and polyfluoroalkyl substances on military installations receive information regarding such exposure, and for other purposes.
    
    Sponsor:
    Rep. Shea-Porter, Carol [D-NH-1] (Introduced 05/22/2018) Cosponsors: (3)
    
    
    Committees:
    House - Veterans' Affairs, Armed Services
    
    
    Latest Action:
    House - 05/22/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        64.
        H.R.5920 — 115th Congress (2017-2018)
    To direct the Secretary of Veterans Affairs and the Secretary of Defense to submit to Congress an annual report on open burn pits, and for other purposes.
    
    Sponsor: Rep. Shea-Porter, Carol [D-NH-1] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Veterans' Affairs, Armed Services        
     Latest Action:             House - 05/22/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        64.
        H.R.5920 — 115th Congress (2017-2018)
    To direct the Secretary of Veterans Affairs and the Secretary of Defense to submit to Congress an annual report on open burn pits, and for other purposes.
    
    Sponsor:
    Rep. Shea-Porter, Carol [D-NH-1] (Introduced 05/22/2018) Cosponsors: (0)
    
    
    Committees:
    House - Veterans' Affairs, Armed Services
    
    
    Latest Action:
    House - 05/22/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        65.
        H.R.5919 — 115th Congress (2017-2018)
    To establish the position of Senior Anticorruption Officer at the Department of State, the United States Agency for International Development, and the Department of Defense, and for other purposes.
    
    Sponsor: Rep. Shea-Porter, Carol [D-NH-1] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Foreign Affairs, Armed Services        
     Latest Action:             House - 05/22/2018 Referred to the Committee on Foreign Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee concerned. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        65.
        H.R.5919 — 115th Congress (2017-2018)
    To establish the position of Senior Anticorruption Officer at the Department of State, the United States Agency for International Development, and the Department of Defense, and for other purposes.
    
    Sponsor:
    Rep. Shea-Porter, Carol [D-NH-1] (Introduced 05/22/2018) Cosponsors: (0)
    
    
    Committees:
    House - Foreign Affairs, Armed Services
    
    
    Latest Action:
    House - 05/22/2018 Referred to the Committee on Foreign Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee concerned. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        66.
        H.R.5918 — 115th Congress (2017-2018)
    To direct the Secretary of Defense to carry out a program on service dog training for members of the Armed Forces with post-traumatic stress disorder or other post-deployment mental health conditions.
    
    Sponsor: Rep. Shea-Porter, Carol [D-NH-1] (Introduced 05/22/2018) Cosponsors: (4)        
    
    Committees: House - Armed Services        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Armed Services. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        66.
        H.R.5918 — 115th Congress (2017-2018)
    To direct the Secretary of Defense to carry out a program on service dog training for members of the Armed Forces with post-traumatic stress disorder or other post-deployment mental health conditions.
    
    Sponsor:
    Rep. Shea-Porter, Carol [D-NH-1] (Introduced 05/22/2018) Cosponsors: (4)
    
    
    Committees:
    House - Armed Services
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Armed Services. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        67.
        H.R.5917 — 115th Congress (2017-2018)
    To authorize the Secretary of Health and Human Services to award grants for career support for skilled, internationally educated health professionals, and for other purposes.
    
    Sponsor: Rep. Roybal-Allard, Lucille [D-CA-40] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        67.
        H.R.5917 — 115th Congress (2017-2018)
    To authorize the Secretary of Health and Human Services to award grants for career support for skilled, internationally educated health professionals, and for other purposes.
    
    Sponsor:
    Rep. Roybal-Allard, Lucille [D-CA-40] (Introduced 05/22/2018) Cosponsors: (0)
    
    
    Committees:
    House - Energy and Commerce
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        68.
        H.R.5916 — 115th Congress (2017-2018)
    To amend the Internal Revenue Code of 1986 to impose a tax on institutions of higher education that fail to use 33 percent of the growth in endowment value for grants for working-family students each year, and for other purposes.
    
    Sponsor: Rep. Reed, Tom [R-NY-23] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Ways and Means, Education and the Workforce        
     Latest Action:             House - 05/22/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        68.
        H.R.5916 — 115th Congress (2017-2018)
    To amend the Internal Revenue Code of 1986 to impose a tax on institutions of higher education that fail to use 33 percent of the growth in endowment value for grants for working-family students each year, and for other purposes.
    
    Sponsor:
    Rep. Reed, Tom [R-NY-23] (Introduced 05/22/2018) Cosponsors: (0)
    
    
    Committees:
    House - Ways and Means, Education and the Workforce
    
    
    Latest Action:
    House - 05/22/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        69.
        H.R.5915 — 115th Congress (2017-2018)
    To amend the TRIO programs to require priority to be given to homeless children and youth, and students in foster care.
    
    Sponsor: Rep. Mitchell, Paul [R-MI-10] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        69.
        H.R.5915 — 115th Congress (2017-2018)
    To amend the TRIO programs to require priority to be given to homeless children and youth, and students in foster care.
    
    Sponsor:
    Rep. Mitchell, Paul [R-MI-10] (Introduced 05/22/2018) Cosponsors: (0)
    
    
    Committees:
    House - Education and the Workforce
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Education and the Workforce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        70.
        H.R.5914 — 115th Congress (2017-2018)
    To require a study and report on policy and regulatory changes that may have contributed to the opioid epidemic.
    
    Sponsor: Rep. Meadows, Mark [R-NC-11] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        70.
        H.R.5914 — 115th Congress (2017-2018)
    To require a study and report on policy and regulatory changes that may have contributed to the opioid epidemic.
    
    Sponsor:
    Rep. Meadows, Mark [R-NC-11] (Introduced 05/22/2018) Cosponsors: (0)
    
    
    Committees:
    House - Energy and Commerce
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        71.
        H.R.5913 — 115th Congress (2017-2018)
    To amend the Internal Revenue Code of 1986 to increase the limitation on the state and local tax deduction for married individuals, and for other purposes.
    
    Sponsor: Rep. MacArthur, Thomas [R-NJ-3] (Introduced 05/22/2018) Cosponsors: (1)        
    
    Committees: House - Ways and Means        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Ways and Means. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        71.
        H.R.5913 — 115th Congress (2017-2018)
    To amend the Internal Revenue Code of 1986 to increase the limitation on the state and local tax deduction for married individuals, and for other purposes.
    
    Sponsor:
    Rep. MacArthur, Thomas [R-NJ-3] (Introduced 05/22/2018) Cosponsors: (1)
    
    
    Committees:
    House - Ways and Means
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Ways and Means. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        72.
        H.R.5912 — 115th Congress (2017-2018)
    To amend title XIX of the Social Security Act to delay the reduction in Federal medical assistance percentage for Medicaid personal care services and home health services furnished without an electronic visit verification system, and for other purposes.
    
    Sponsor: Rep. Langevin, James R. [D-RI-2] (Introduced 05/22/2018) Cosponsors: (3)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        72.
        H.R.5912 — 115th Congress (2017-2018)
    To amend title XIX of the Social Security Act to delay the reduction in Federal medical assistance percentage for Medicaid personal care services and home health services furnished without an electronic visit verification system, and for other purposes.
    
    Sponsor:
    Rep. Langevin, James R. [D-RI-2] (Introduced 05/22/2018) Cosponsors: (3)
    
    
    Committees:
    House - Energy and Commerce
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        73.
        H.R.5911 — 115th Congress (2017-2018)
    To amend Public Law 115-97 (commonly known as the Tax Cuts and Jobs Act) to repeal the Arctic National Wildlife Refuge oil and gas program, and for other purposes.
    
    Sponsor: Rep. Huffman, Jared [D-CA-2] (Introduced 05/22/2018) Cosponsors: (4)        
    
    Committees: House - Natural Resources        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Natural Resources. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        73.
        H.R.5911 — 115th Congress (2017-2018)
    To amend Public Law 115-97 (commonly known as the Tax Cuts and Jobs Act) to repeal the Arctic National Wildlife Refuge oil and gas program, and for other purposes.
    
    Sponsor:
    Rep. Huffman, Jared [D-CA-2] (Introduced 05/22/2018) Cosponsors: (4)
    
    
    Committees:
    House - Natural Resources
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Natural Resources. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        74.
        H.R.5910 — 115th Congress (2017-2018)
    To strengthen the United States response to Russian interference, and for other purposes.
    
    Sponsor: Rep. Demings, Val Butler [D-FL-10] (Introduced 05/22/2018) Cosponsors: (2)        
    
    Committees: House - Foreign Affairs, Armed Services, Intelligence (Permanent Select), Oversight and Government Reform, Financial Services        
     Latest Action:             House - 05/22/2018 Referred to the Committee on Foreign Affairs, and in addition to the Committees on Armed Services, Intelligence (Permanent Select), Oversight and Government Reform, and Financial Services, for a period to be subsequently determined by the Speaker, in each case for... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        74.
        H.R.5910 — 115th Congress (2017-2018)
    To strengthen the United States response to Russian interference, and for other purposes.
    
    Sponsor:
    Rep. Demings, Val Butler [D-FL-10] (Introduced 05/22/2018) Cosponsors: (2)
    
    
    Committees:
    House - Foreign Affairs, Armed Services, Intelligence (Permanent Select), Oversight and Government Reform, Financial Services
    
    
    Latest Action:
    House - 05/22/2018 Referred to the Committee on Foreign Affairs, and in addition to the Committees on Armed Services, Intelligence (Permanent Select), Oversight and Government Reform, and Financial Services, for a period to be subsequently determined by the Speaker, in each case for... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        75.
        H.R.5909 — 115th Congress (2017-2018)
    To enhance reciprocal market access for United States domestic producers in the negotiating process of bilateral, regional, and multilateral trade agreements.
    
    Sponsor: Rep. DeLauro, Rosa L. [D-CT-3] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Ways and Means        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Ways and Means. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        75.
        H.R.5909 — 115th Congress (2017-2018)
    To enhance reciprocal market access for United States domestic producers in the negotiating process of bilateral, regional, and multilateral trade agreements.
    
    Sponsor:
    Rep. DeLauro, Rosa L. [D-CT-3] (Introduced 05/22/2018) Cosponsors: (0)
    
    
    Committees:
    House - Ways and Means
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Ways and Means. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        76.
        H.R.5908 — 115th Congress (2017-2018)
    To protect victims of crime or serious labor violations from removal during Department of Homeland Security enforcement actions, and for other purposes.
    
    Sponsor: Rep. Chu, Judy [D-CA-27] (Introduced 05/22/2018) Cosponsors: (6)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        76.
        H.R.5908 — 115th Congress (2017-2018)
    To protect victims of crime or serious labor violations from removal during Department of Homeland Security enforcement actions, and for other purposes.
    
    Sponsor:
    Rep. Chu, Judy [D-CA-27] (Introduced 05/22/2018) Cosponsors: (6)
    
    
    Committees:
    House - Judiciary
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on the Judiciary. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        77.
        H.R.5907 — 115th Congress (2017-2018)
    To provide directors of the National Laboratories signature authority for certain agreements, and for other purposes.
    
    Sponsor: Rep. Hultgren, Randy [R-IL-14] (Introduced 05/22/2018) Cosponsors: (11)        
    
    Committees: House - Science, Space, and Technology        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        77.
        H.R.5907 — 115th Congress (2017-2018)
    To provide directors of the National Laboratories signature authority for certain agreements, and for other purposes.
    
    Sponsor:
    Rep. Hultgren, Randy [R-IL-14] (Introduced 05/22/2018) Cosponsors: (11)
    
    
    Committees:
    House - Science, Space, and Technology
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        78.
        H.R.5906 — 115th Congress (2017-2018)
    To amend the America COMPETES Act to establish Department of Energy policy for Advanced Research Projects Agency-Energy, and for other purposes.
    
    Sponsor: Rep. Lucas, Frank D. [R-OK-3] (Introduced 05/22/2018) Cosponsors: (9)        
    
    Committees: House - Science, Space, and Technology        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        78.
        H.R.5906 — 115th Congress (2017-2018)
    To amend the America COMPETES Act to establish Department of Energy policy for Advanced Research Projects Agency-Energy, and for other purposes.
    
    Sponsor:
    Rep. Lucas, Frank D. [R-OK-3] (Introduced 05/22/2018) Cosponsors: (9)
    
    
    Committees:
    House - Science, Space, and Technology
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        79.
        H.R.5905 — 115th Congress (2017-2018)
    To authorize basic research programs in the Department of Energy Office of Science for fiscal years 2018 and 2019.
    
    Sponsor: Rep. Weber, Randy K., Sr. [R-TX-14] (Introduced 05/22/2018) Cosponsors: (11)        
    
    Committees: House - Science, Space, and Technology        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        79.
        H.R.5905 — 115th Congress (2017-2018)
    To authorize basic research programs in the Department of Energy Office of Science for fiscal years 2018 and 2019.
    
    Sponsor:
    Rep. Weber, Randy K., Sr. [R-TX-14] (Introduced 05/22/2018) Cosponsors: (11)
    
    
    Committees:
    House - Science, Space, and Technology
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        80.
        H.R.5904 — 115th Congress (2017-2018)
    To amend the Sherman Act to make oil-producing and exporting cartels illegal.
    
    Sponsor: Rep. Chabot, Steve [R-OH-1] (Introduced 05/22/2018) Cosponsors: (5)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        80.
        H.R.5904 — 115th Congress (2017-2018)
    To amend the Sherman Act to make oil-producing and exporting cartels illegal.
    
    Sponsor:
    Rep. Chabot, Steve [R-OH-1] (Introduced 05/22/2018) Cosponsors: (5)
    
    
    Committees:
    House - Judiciary
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on the Judiciary. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        81.
        H.R.5903 — 115th Congress (2017-2018)
    To amend the Internal Revenue Code of 1986 to make permanent certain changes made by Public Law 115-97 to the child tax credit.
    
    Sponsor: Rep. Smith, Jason [R-MO-8] (Introduced 05/22/2018) Cosponsors: (12)        
    
    Committees: House - Ways and Means        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Ways and Means. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        81.
        H.R.5903 — 115th Congress (2017-2018)
    To amend the Internal Revenue Code of 1986 to make permanent certain changes made by Public Law 115-97 to the child tax credit.
    
    Sponsor:
    Rep. Smith, Jason [R-MO-8] (Introduced 05/22/2018) Cosponsors: (12)
    
    
    Committees:
    House - Ways and Means
    
    
    Latest Action:
    House - 05/22/2018 Referred to the House Committee on Ways and Means. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        82.
        H.R.5902 — 115th Congress (2017-2018)
    To amend the Ethics in Government Act of 1978 to provide for reform in the operations of the Office of Government Ethics, and for other purposes.
    
    Sponsor: Rep. Raskin, Jamie [D-MD-8] (Introduced 05/21/2018) Cosponsors: (22)        
    
    Committees: House - Oversight and Government Reform, Judiciary        
     Latest Action:             House - 05/21/2018 Referred to the Committee on Oversight and Government Reform, and in addition to the Committee on the Judiciary, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        82.
        H.R.5902 — 115th Congress (2017-2018)
    To amend the Ethics in Government Act of 1978 to provide for reform in the operations of the Office of Government Ethics, and for other purposes.
    
    Sponsor:
    Rep. Raskin, Jamie [D-MD-8] (Introduced 05/21/2018) Cosponsors: (22)
    
    
    Committees:
    House - Oversight and Government Reform, Judiciary
    
    
    Latest Action:
    House - 05/21/2018 Referred to the Committee on Oversight and Government Reform, and in addition to the Committee on the Judiciary, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        83.
        H.R.5901 — 115th Congress (2017-2018)
    To amend title 10, United States Code, to permit the Secretary of the Army to produce, treat, manage, and use natural gas located under Fort Knox, Kentucky, and for other purposes.
    
    Sponsor: Rep. Guthrie, Brett [R-KY-2] (Introduced 05/21/2018) Cosponsors: (0)        
    
    Committees: House - Armed Services        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Armed Services. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        83.
        H.R.5901 — 115th Congress (2017-2018)
    To amend title 10, United States Code, to permit the Secretary of the Army to produce, treat, manage, and use natural gas located under Fort Knox, Kentucky, and for other purposes.
    
    Sponsor:
    Rep. Guthrie, Brett [R-KY-2] (Introduced 05/21/2018) Cosponsors: (0)
    
    
    Committees:
    House - Armed Services
    
    
    Latest Action:
    House - 05/21/2018 Referred to the House Committee on Armed Services. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        84.
        H.R.5900 — 115th Congress (2017-2018)
    To provide for a national strategy to address and overcome Lyme disease and other tick-borne diseases, and for other purposes.
    
    Sponsor: Rep. Smith, Christopher H. [R-NJ-4] (Introduced 05/21/2018) Cosponsors: (6)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        84.
        H.R.5900 — 115th Congress (2017-2018)
    To provide for a national strategy to address and overcome Lyme disease and other tick-borne diseases, and for other purposes.
    
    Sponsor:
    Rep. Smith, Christopher H. [R-NJ-4] (Introduced 05/21/2018) Cosponsors: (6)
    
    
    Committees:
    House - Energy and Commerce
    
    
    Latest Action:
    House - 05/21/2018 Referred to the House Committee on Energy and Commerce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        85.
        H.R.5899 — 115th Congress (2017-2018)
    To amend the Public Health Service Act to reauthorize school-based health centers, and for other purposes.
    
    Sponsor: Rep. Faso, John J. [R-NY-19] (Introduced 05/21/2018) Cosponsors: (4)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        85.
        H.R.5899 — 115th Congress (2017-2018)
    To amend the Public Health Service Act to reauthorize school-based health centers, and for other purposes.
    
    Sponsor:
    Rep. Faso, John J. [R-NY-19] (Introduced 05/21/2018) Cosponsors: (4)
    
    
    Committees:
    House - Energy and Commerce
    
    
    Latest Action:
    House - 05/21/2018 Referred to the House Committee on Energy and Commerce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        86.
        H.R.5898 — 115th Congress (2017-2018)
    To require the Secretary of State to develop a strategy on administration policy regarding UNRWA, and for other purposes.
    
    Sponsor: Rep. Cicilline, David N. [D-RI-1] (Introduced 05/21/2018) Cosponsors: (1)        
    
    Committees: House - Foreign Affairs        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Foreign Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        86.
        H.R.5898 — 115th Congress (2017-2018)
    To require the Secretary of State to develop a strategy on administration policy regarding UNRWA, and for other purposes.
    
    Sponsor:
    Rep. Cicilline, David N. [D-RI-1] (Introduced 05/21/2018) Cosponsors: (1)
    
    
    Committees:
    House - Foreign Affairs
    
    
    Latest Action:
    House - 05/21/2018 Referred to the House Committee on Foreign Affairs. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        87.
        H.R.5897 — 115th Congress (2017-2018)
    To require the Secretary of the Army to expedite the completion of certain feasibility studies and reports and to amend the Coastal Barrier Resources Act to ensure public safety, and for other purposes.
    
    Sponsor: Rep. Weber, Randy K., Sr. [R-TX-14] (Introduced 05/21/2018) Cosponsors: (20)        
    
    Committees: House - Transportation and Infrastructure, Natural Resources        
     Latest Action:             House - 05/21/2018 Referred to the Committee on Transportation and Infrastructure, and in addition to the Committee on Natural Resources, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        87.
        H.R.5897 — 115th Congress (2017-2018)
    To require the Secretary of the Army to expedite the completion of certain feasibility studies and reports and to amend the Coastal Barrier Resources Act to ensure public safety, and for other purposes.
    
    Sponsor:
    Rep. Weber, Randy K., Sr. [R-TX-14] (Introduced 05/21/2018) Cosponsors: (20)
    
    
    Committees:
    House - Transportation and Infrastructure, Natural Resources
    
    
    Latest Action:
    House - 05/21/2018 Referred to the Committee on Transportation and Infrastructure, and in addition to the Committee on Natural Resources, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        88.
        H.R.5896 — 115th Congress (2017-2018)
    To amend title 5, United States Code, to modify the authority for pay and work schedules of border patrol agents, and for other purposes.
    
    Sponsor: Rep. Hurd, Will [R-TX-23] (Introduced 05/21/2018) Cosponsors: (3)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/23/2018 Ordered to be Reported (Amended) by Voice Vote. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        88.
        H.R.5896 — 115th Congress (2017-2018)
    To amend title 5, United States Code, to modify the authority for pay and work schedules of border patrol agents, and for other purposes.
    
    Sponsor:
    Rep. Hurd, Will [R-TX-23] (Introduced 05/21/2018) Cosponsors: (3)
    
    
    Committees:
    House - Oversight and Government Reform
    
    
    Latest Action:
    House - 05/23/2018 Ordered to be Reported (Amended) by Voice Vote. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        89.
        H.R.5895 — 115th Congress (2017-2018)
    Energy and Water Development and Related Agencies Appropriations Act, 2019
    
    Sponsor: Rep. Simpson, Michael K. [R-ID-2] (Introduced 05/21/2018) Cosponsors: (0)        
    
    Committees: House - Appropriations        
     Latest Action:             House - 05/21/2018 Placed on the Union Calendar, Calendar No. 540. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-697, by Mr. Simpson.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-697, by Mr. Simpson.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        89.
        H.R.5895 — 115th Congress (2017-2018)
    Energy and Water Development and Related Agencies Appropriations Act, 2019
    
    Sponsor:
    Rep. Simpson, Michael K. [R-ID-2] (Introduced 05/21/2018) Cosponsors: (0)
    
    
    Committees:
    House - Appropriations
    
    
    Latest Action:
    House - 05/21/2018 Placed on the Union Calendar, Calendar No. 540. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-697, by Mr. Simpson.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-697, by Mr. Simpson.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        90.
        H.R.5894 — 115th Congress (2017-2018)
    Legislative Branch Appropriations Act, 2019
    
    Sponsor: Rep. Yoder, Kevin [R-KS-3] (Introduced 05/21/2018) Cosponsors: (0)        
    
    Committees: House - Appropriations        
    
    Committee Reports: H. Rept. 115-696 
     Latest Action:             House - 05/21/2018 Placed on the Union Calendar, Calendar No. 539. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-696, by Mr. Yoder.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-696, by Mr. Yoder.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        90.
        H.R.5894 — 115th Congress (2017-2018)
    Legislative Branch Appropriations Act, 2019
    
    Sponsor:
    Rep. Yoder, Kevin [R-KS-3] (Introduced 05/21/2018) Cosponsors: (0)
    
    
    Committees:
    House - Appropriations
    
    
    Committee Reports:
    H. Rept. 115-696
    
    
    Latest Action:
    House - 05/21/2018 Placed on the Union Calendar, Calendar No. 539. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-696, by Mr. Yoder.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-696, by Mr. Yoder.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        91.
        H.R.5893 — 115th Congress (2017-2018)
    To require a certain percentage of liquefied natural gas and crude oil exports be transported on United States-built and United States-flag vessels, and for other purposes.
    
    Sponsor: Rep. Garamendi, John [D-CA-3] (Introduced 05/21/2018) Cosponsors: (3)        
    
    Committees: House - Energy and Commerce, Foreign Affairs        
     Latest Action:             House - 05/21/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committee on Foreign Affairs, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        91.
        H.R.5893 — 115th Congress (2017-2018)
    To require a certain percentage of liquefied natural gas and crude oil exports be transported on United States-built and United States-flag vessels, and for other purposes.
    
    Sponsor:
    Rep. Garamendi, John [D-CA-3] (Introduced 05/21/2018) Cosponsors: (3)
    
    
    Committees:
    House - Energy and Commerce, Foreign Affairs
    
    
    Latest Action:
    House - 05/21/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committee on Foreign Affairs, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        92.
        H.R.5892 — 115th Congress (2017-2018)
    To establish an Advisory Committee on Opioids and the Workplace to advise the Secretary of Labor on actions the Department of Labor can take to address the impact of opioid abuse on the workplace.
    
    Sponsor: Rep. Lewis, Jason [R-MN-2] (Introduced 05/21/2018) Cosponsors: (1)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        92.
        H.R.5892 — 115th Congress (2017-2018)
    To establish an Advisory Committee on Opioids and the Workplace to advise the Secretary of Labor on actions the Department of Labor can take to address the impact of opioid abuse on the workplace.
    
    Sponsor:
    Rep. Lewis, Jason [R-MN-2] (Introduced 05/21/2018) Cosponsors: (1)
    
    
    Committees:
    House - Education and the Workforce
    
    
    Latest Action:
    House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        93.
        H.R.5891 — 115th Congress (2017-2018)
    To establish an interagency task force to improve the Federal response to families impacted by substance abuse disorders.
    
    Sponsor: Rep. Grothman, Glenn [R-WI-6] (Introduced 05/21/2018) Cosponsors: (2)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        93.
        H.R.5891 — 115th Congress (2017-2018)
    To establish an interagency task force to improve the Federal response to families impacted by substance abuse disorders.
    
    Sponsor:
    Rep. Grothman, Glenn [R-WI-6] (Introduced 05/21/2018) Cosponsors: (2)
    
    
    Committees:
    House - Education and the Workforce
    
    
    Latest Action:
    House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        94.
        H.R.5890 — 115th Congress (2017-2018)
    To require the Secretary of Health and Human Services to provide assistance to States in complying with, and implementing, certain provisions of section 106 of the Child Abuse Prevention and Treatment Act in order to promote better protections for young children and family-centered responses, and for other purposes.
    
    Sponsor: Rep. Garrett, Thomas A., Jr. [R-VA-5] (Introduced 05/21/2018) Cosponsors: (1)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        94.
        H.R.5890 — 115th Congress (2017-2018)
    To require the Secretary of Health and Human Services to provide assistance to States in complying with, and implementing, certain provisions of section 106 of the Child Abuse Prevention and Treatment Act in order to promote better protections for young children and family-centered responses, and for other purposes.
    
    Sponsor:
    Rep. Garrett, Thomas A., Jr. [R-VA-5] (Introduced 05/21/2018) Cosponsors: (1)
    
    
    Committees:
    House - Education and the Workforce
    
    
    Latest Action:
    House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        95.
        H.R.5889 — 115th Congress (2017-2018)
    To require the Secretary of Health and Human Services to disseminate information, resources, and if requested, technical assistance to early childhood care and education providers and professionals working with young children on ways to properly recognize and respond to children who may be impacted by trauma related to substance abuse.
    
    Sponsor: Rep. Brat, Dave [R-VA-7] (Introduced 05/21/2018) Cosponsors: (2)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        95.
        H.R.5889 — 115th Congress (2017-2018)
    To require the Secretary of Health and Human Services to disseminate information, resources, and if requested, technical assistance to early childhood care and education providers and professionals working with young children on ways to properly recognize and respond to children who may be impacted by trauma related to substance abuse.
    
    Sponsor:
    Rep. Brat, Dave [R-VA-7] (Introduced 05/21/2018) Cosponsors: (2)
    
    
    Committees:
    House - Education and the Workforce
    
    
    Latest Action:
    House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        96.
        H.R.5888 — 115th Congress (2017-2018)
    To amend part A of title IV of the Social Security Act to provide grants for coordination of the TANF program with career pathways.
    
    Sponsor: Rep. Neal, Richard E. [D-MA-1] (Introduced 05/21/2018) Cosponsors: (14)        
    
    Committees: House - Ways and Means, Education and the Workforce        
     Latest Action:             House - 05/21/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        96.
        H.R.5888 — 115th Congress (2017-2018)
    To amend part A of title IV of the Social Security Act to provide grants for coordination of the TANF program with career pathways.
    
    Sponsor:
    Rep. Neal, Richard E. [D-MA-1] (Introduced 05/21/2018) Cosponsors: (14)
    
    
    Committees:
    House - Ways and Means, Education and the Workforce
    
    
    Latest Action:
    House - 05/21/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        97.
        H.R.5887 — 115th Congress (2017-2018)
    To amend the Leahy-Smith America Invents Act to extend the period during which the Under Secretary of Commerce for Intellectual Property and Director of the United States Patent and Trademark Office may set or adjust certain fees, and for other purposes.
    
    Sponsor: Rep. Chabot, Steve [R-OH-1] (Introduced 05/21/2018) Cosponsors: (1)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        97.
        H.R.5887 — 115th Congress (2017-2018)
    To amend the Leahy-Smith America Invents Act to extend the period during which the Under Secretary of Commerce for Intellectual Property and Director of the United States Patent and Trademark Office may set or adjust certain fees, and for other purposes.
    
    Sponsor:
    Rep. Chabot, Steve [R-OH-1] (Introduced 05/21/2018) Cosponsors: (1)
    
    
    Committees:
    House - Judiciary
    
    
    Latest Action:
    House - 05/21/2018 Referred to the House Committee on the Judiciary. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        98.
        H.R.5886 — 115th Congress (2017-2018)
    To apply the Bank Secrecy Act to dealers in art or antiquities.
    
    Sponsor: Rep. Messer, Luke [R-IN-6] (Introduced 05/18/2018) Cosponsors: (0)        
    
    Committees: House - Financial Services        
     Latest Action:             House - 05/18/2018 Referred to the House Committee on Financial Services. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        98.
        H.R.5886 — 115th Congress (2017-2018)
    To apply the Bank Secrecy Act to dealers in art or antiquities.
    
    Sponsor:
    Rep. Messer, Luke [R-IN-6] (Introduced 05/18/2018) Cosponsors: (0)
    
    
    Committees:
    House - Financial Services
    
    
    Latest Action:
    House - 05/18/2018 Referred to the House Committee on Financial Services. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        99.
        H.R.5885 — 115th Congress (2017-2018)
    To reauthorize the Partners for Fish and Wildlife Program and certain wildlife conservation funds, to establish prize competitions relating to the prevention of wildlife poaching and trafficking, wildlife conservation, the management of invasive species, and the protection of endangered species, and for other purposes.
    
    Sponsor: Rep. Lowenthal, Alan S. [D-CA-47] (Introduced 05/18/2018) Cosponsors: (1)        
    
    Committees: House - Natural Resources, Science, Space, and Technology        
     Latest Action:             House - 05/18/2018 Referred to the Committee on Natural Resources, and in addition to the Committee on Science, Space, and Technology, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        99.
        H.R.5885 — 115th Congress (2017-2018)
    To reauthorize the Partners for Fish and Wildlife Program and certain wildlife conservation funds, to establish prize competitions relating to the prevention of wildlife poaching and trafficking, wildlife conservation, the management of invasive species, and the protection of endangered species, and for other purposes.
    
    Sponsor:
    Rep. Lowenthal, Alan S. [D-CA-47] (Introduced 05/18/2018) Cosponsors: (1)
    
    
    Committees:
    House - Natural Resources, Science, Space, and Technology
    
    
    Latest Action:
    House - 05/18/2018 Referred to the Committee on Natural Resources, and in addition to the Committee on Science, Space, and Technology, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
     BILL
        100.
        H.R.5884 — 115th Congress (2017-2018)
    To amend title 18, United States Code, to punish unlawful obstruction of the enforcement of the laws of the United States by State officials, and for other purposes.
    
    Sponsor: Rep. King, Steve [R-IA-4] (Introduced 05/18/2018) Cosponsors: (1)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/18/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law
    ===================
        100.
        H.R.5884 — 115th Congress (2017-2018)
    To amend title 18, United States Code, to punish unlawful obstruction of the enforcement of the laws of the United States by State officials, and for other purposes.
    
    Sponsor:
    Rep. King, Steve [R-IA-4] (Introduced 05/18/2018) Cosponsors: (1)
    
    
    Committees:
    House - Judiciary
    
    
    Latest Action:
    House - 05/18/2018 Referred to the House Committee on the Judiciary. (All Actions)
    
    
    Tracker:
    This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law
    
    
    ===================
    IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    
    ===================
    Passed House
    ===================
    Passed Senate
    ===================
    To President
    ===================
    Became Law


**Using `find_all` with class specified**


```python
for child in ordered.find_all('li', attrs={'class':'expanded'}):
    print("===================")
    print(child.text)
```

    ===================
     BILL
        1.
        H.R.5983 — 115th Congress (2017-2018)
    To amend the Communications Act of 1934 to require providers of a covered service to provide location information concerning the telecommunications device of a user of such service to an investigative or law enforcement officer or an employee or other agent of a public safety answering point in an emergency situation involving risk of death or serious physical harm or in order to respond to the user's call for emergency services.
    
    Sponsor: Rep. Yoder, Kevin [R-KS-3] (Introduced 05/25/2018) Cosponsors: (2)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        2.
        H.R.5982 — 115th Congress (2017-2018)
    To amend title 5, United States Code, to increase the gratuity owed upon death of an employee in connection with the employee's service with an Armed Force, to limit the amount of any death gratuity paid upon the death of a Member of Congress, and for other purposes.
    
    Sponsor: Rep. Walorski, Jackie [R-IN-2] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Education and the Workforce, House Administration        
     Latest Action:             House - 05/25/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on House Administration, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        3.
        H.R.5981 — 115th Congress (2017-2018)
    To amend title 44, United States Code, to prohibit the Archivist from charging certain fees to veterans for destroyed records regarding such veterans, and for other purposes.
    
    Sponsor: Rep. Smith, Christopher H. [R-NJ-4] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        4.
        H.R.5980 — 115th Congress (2017-2018)
    To authorize, develop, and implement a coordinated tracking system of federally-funded initiatives and grant programs for substance abuse treatment, prevention, and enforcement, and for other purposes.
    
    Sponsor: Rep. Rothfus, Keith J. [R-PA-12] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        5.
        H.R.5979 — 115th Congress (2017-2018)
    To establish the Mill Springs Battlefield National Monument in the State of Kentucky as a unit of the National Park System, and for other purposes.
    
    Sponsor: Rep. Rogers, Harold [R-KY-5] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Natural Resources        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Natural Resources. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        6.
        H.R.5978 — 115th Congress (2017-2018)
    To amend the Food Security Act of 1985 to provide for certain payment limitations with respect to commodity programs, and for other purposes.
    
    Sponsor: Rep. Meadows, Mark [R-NC-11] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Agriculture        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Agriculture. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        7.
        H.R.5977 — 115th Congress (2017-2018)
    To improve Federal efforts with respect to the prevention of maternal mortality, and for other purposes.
    
    Sponsor: Rep. Kelly, Robin L. [D-IL-2] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        8.
        H.R.5976 — 115th Congress (2017-2018)
    To amend the Individuals with Disabilities Education Act to direct the Secretary to provide additional funds to States to establish and make disbursements from high cost funds.
    
    Sponsor: Rep. Huffman, Jared [D-CA-2] (Introduced 05/25/2018) Cosponsors: (2)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        9.
        H.R.5975 — 115th Congress (2017-2018)
    To support businesses in Puerto Rico, extend child tax credits for families in Puerto Rico, and for other purposes.
    
    Sponsor: Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large] (Introduced 05/25/2018) Cosponsors: (5)        
    
    Committees: House - Ways and Means, Small Business, Financial Services, Oversight and Government Reform, Energy and Commerce        
     Latest Action:             House - 05/25/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Small Business, Financial Services, Oversight and Government Reform, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        10.
        H.R.5974 — 115th Congress (2017-2018)
    To direct the Secretary of Veterans Affairs to use on-site regulated medical waste treatment systems at certain Department of Veterans Affairs facilities, and for other purposes.
    
    Sponsor: Rep. Denham, Jeff [R-CA-10] (Introduced 05/25/2018) Cosponsors: (3)        
    
    Committees: House - Veterans' Affairs        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Veterans' Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        11.
        H.R.5973 — 115th Congress (2017-2018)
    To amend the Robert T. Stafford Disaster Relief and Emergency Assistance Act to require a report on risk transfer, and for other purposes.
    
    Sponsor: Rep. Ross, Dennis A. [R-FL-15] (Introduced 05/25/2018) Cosponsors: (0)        
    
    Committees: House - Transportation and Infrastructure        
     Latest Action:             House - 05/25/2018 Referred to the House Committee on Transportation and Infrastructure. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-25
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        12.
        H.R.5972 — 115th Congress (2017-2018)
    To amend section 502 of title 40, United States Code, to allow State and local governments to purchase from the Federal supply schedule, and for other purposes.
    
    Sponsor: Rep. Zeldin, Lee M. [R-NY-1] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        13.
        H.R.5971 — 115th Congress (2017-2018)
    To include nonprofit and volunteer ground and air ambulance crew members and first responders for certain benefits.
    
    Sponsor: Rep. Zeldin, Lee M. [R-NY-1] (Introduced 05/24/2018) Cosponsors: (0)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        14.
        H.R.5970 — 115th Congress (2017-2018)
    To require the Securities and Exchange Commission to implement rules simplifying the quarterly financial reporting regime.
    
    Sponsor: Rep. Wagner, Ann [R-MO-2] (Introduced 05/24/2018) Cosponsors: (0)        
    
    Committees: House - Financial Services        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Financial Services. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        15.
        H.R.5969 — 115th Congress (2017-2018)
    To prohibit the use of Federal funds for the provision of broadband service in any State that has in effect a law, regulation, or other requirement that prohibits, limits, places conditions on, or regulates the provision of broadband service by public, cooperative, or nonprofit broadband providers.
    
    Sponsor: Rep. Pocan, Mark [D-WI-2] (Introduced 05/24/2018) Cosponsors: (0)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        16.
        H.R.5968 — 115th Congress (2017-2018)
    To encourage online workforce training.
    
    Sponsor: Rep. Larsen, Rick [D-WA-2] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        17.
        H.R.5967 — 115th Congress (2017-2018)
    To establish a single export promotion agency in the executive branch, and for other purposes.
    
    Sponsor: Rep. Kuster, Ann M. [D-NH-2] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Foreign Affairs        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Foreign Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        18.
        H.R.5966 — 115th Congress (2017-2018)
    To improve the provision of health care for women veterans by the Department of Veterans Affairs, and for other purposes.
    
    Sponsor: Rep. Keating, William R. [D-MA-9] (Introduced 05/24/2018) Cosponsors: (3)        
    
    Committees: House - Veterans' Affairs        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Veterans' Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        19.
        H.R.5965 — 115th Congress (2017-2018)
    To require health insurance coverage for the treatment of infertility.
    
    Sponsor: Rep. DeLauro, Rosa L. [D-CT-3] (Introduced 05/24/2018) Cosponsors: (0)        
    
    Committees: House - Energy and Commerce, Oversight and Government Reform, Armed Services, Veterans' Affairs        
     Latest Action:             House - 05/24/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committees on Oversight and Government Reform, Armed Services, and Veterans' Affairs, for a period to be subsequently determined by the Speaker, in each case for consideration of such... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        20.
        H.R.5964 — 115th Congress (2017-2018)
    To amend the Professional Boxing Safety Act of 1996 to provide additional safety standards for professional boxing.
    
    Sponsor: Rep. Cartwright, Matt [D-PA-17] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Education and the Workforce, Energy and Commerce        
     Latest Action:             House - 05/24/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        21.
        H.R.5963 — 115th Congress (2017-2018)
    To delay the reimposition of the annual fee on health insurance providers until after 2020.
    
    Sponsor: Rep. Noem, Kristi L. [R-SD-At Large] (Introduced 05/24/2018) Cosponsors: (3)        
    
    Committees: House - Ways and Means, Energy and Commerce        
     Latest Action:             House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        22.
        H.R.5962 — 115th Congress (2017-2018)
    To provide for loan forgiveness for STEM teachers, and for other purposes.
    
    Sponsor: Rep. Swalwell, Eric [D-CA-15] (Introduced 05/24/2018) Cosponsors: (4)        
    
    Committees: House - Ways and Means, Education and the Workforce        
     Latest Action:             House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        23.
        H.R.5961 — 115th Congress (2017-2018)
    Making appropriations for Agriculture, Rural Development, Food and Drug Administration, and Related Agencies programs for the fiscal year ending September 30, 2019, and for other purposes.
    
    Sponsor: Rep. Aderholt, Robert B. [R-AL-4] (Introduced 05/24/2018) Cosponsors: (0)        
    
    Committees: House - Appropriations        
    
    Committee Reports: H. Rept. 115-706 
     Latest Action:             House - 05/24/2018 Placed on the Union Calendar, Calendar No. 545. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-706, by Mr. Aderholt.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        24.
        H.R.5960 — 115th Congress (2017-2018)
    To direct the Attorney General to make grants to regional gang task forces to prevent violence committed by and against youths, and for other purposes.
    
    Sponsor: Rep. Connolly, Gerald E. [D-VA-11] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        25.
        H.R.5959 — 115th Congress (2017-2018)
    To promote national security and jobs through the use of natural gas to fuel heavy-duty trucks and fleet vehicles.
    
    Sponsor: Rep. Mullin, Markwayne [R-OK-2] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Ways and Means, Oversight and Government Reform, Energy and Commerce, Science, Space, and Technology        
     Latest Action:             House - 05/24/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Oversight and Government Reform, Energy and Commerce, and Science, Space, and Technology, for a period to be subsequently determined by the Speaker, in each case for consideration of... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        26.
        H.R.5958 — 115th Congress (2017-2018)
    To amend title XVIII of the Social Security Act to require pharmacy-negotiated price concessions and pharmacy incentive payments and adjustments to be included in negotiated prices at the point-of-sale under part D of the Medicare program, and for other purposes.
    
    Sponsor: Rep. Collins, Doug [R-GA-9] (Introduced 05/24/2018) Cosponsors: (3)        
    
    Committees: House - Energy and Commerce, Ways and Means        
     Latest Action:             House - 05/24/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committee on Ways and Means, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        27.
        H.R.5957 — 115th Congress (2017-2018)
    To establish the Caddo Lake National Heritage Area, and for other purposes.
    
    Sponsor: Rep. Gohmert, Louie [R-TX-1] (Introduced 05/24/2018) Cosponsors: (2)        
    
    Committees: House - Natural Resources        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Natural Resources. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        28.
        H.R.5956 — 115th Congress (2017-2018)
    To incentivize the hiring of United States workers in the Commonwealth of the Northern Mariana Islands, and for other purposes.
    
    Sponsor: Rep. Bishop, Rob [R-UT-1] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Natural Resources        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Natural Resources. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        29.
        H.R.5955 — 115th Congress (2017-2018)
    To reauthorize subtitle A of the Victims of Child Abuse Act of 1990.
    
    Sponsor: Rep. Poe, Ted [R-TX-2] (Introduced 05/24/2018) Cosponsors: (13)        
    
    Committees: House - Judiciary, Education and the Workforce        
     Latest Action:             House - 05/24/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        30.
        H.R.5954 — 115th Congress (2017-2018)
    To amend title 18, United States Code, to clarify the meaning of the terms "act of war" and "blocked asset", and for other purposes.
    
    Sponsor: Rep. Goodlatte, Bob [R-VA-6] (Introduced 05/24/2018) Cosponsors: (4)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        31.
        H.R.5953 — 115th Congress (2017-2018)
    To provide regulatory relief to charitable organizations that provide housing assistance, and for other purposes.
    
    Sponsor: Rep. Loudermilk, Barry [R-GA-11] (Introduced 05/24/2018) Cosponsors: (1)        
    
    Committees: House - Financial Services        
     Latest Action:             House - 05/24/2018 Referred to the House Committee on Financial Services. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        32.
        H.R.5952 — 115th Congress (2017-2018)
    Science Appropriations Act, 2019
    
    Sponsor: Rep. Culberson, John Abney [R-TX-7] (Introduced 05/24/2018) Cosponsors: (0)        
    
    Committees: House - Appropriations        
    
    Committee Reports: H. Rept. 115-704 
     Latest Action:             House - 05/24/2018 Placed on the Union Calendar, Calendar No. 544. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-24
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-704, by Mr. Culberson.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        33.
        H.R.5951 — 115th Congress (2017-2018)
    To establish the Veterans Crisis Response Corps, and for other purposes.
    
    Sponsor: Rep. Schiff, Adam B. [D-CA-28] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Veterans' Affairs, Transportation and Infrastructure, Foreign Affairs, Armed Services        
     Latest Action:             House - 05/23/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committees on Transportation and Infrastructure, Foreign Affairs, and Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        34.
        H.R.5950 — 115th Congress (2017-2018)
    To protect children affected by immigration enforcement actions.
    
    Sponsor: Rep. Roybal-Allard, Lucille [D-CA-40] (Introduced 05/23/2018) Cosponsors: (6)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        35.
        H.R.5949 — 115th Congress (2017-2018)
    To exempt certain motor carriers engaged in agricultural business from the electronic logging device requirements, and for other purposes.
    
    Sponsor: Rep. Peterson, Collin C. [D-MN-7] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Transportation and Infrastructure        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Transportation and Infrastructure. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        36.
        H.R.5948 — 115th Congress (2017-2018)
    To exempt motor carriers that own or operate 10 or fewer commercial vehicles from the electronic logging device mandates, and for other purposes.
    
    Sponsor: Rep. Peterson, Collin C. [D-MN-7] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Transportation and Infrastructure        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Transportation and Infrastructure. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        37.
        H.R.5947 — 115th Congress (2017-2018)
    To repeal the Asia Foundation Act, and for other purposes.
    
    Sponsor: Rep. Norman, Ralph [R-SC-5] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Foreign Affairs        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Foreign Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        38.
        H.R.5946 — 115th Congress (2017-2018)
    To provide that Members of Congress shall not be paid if Congress has not approved a concurrent resolution on the budget and passed the regular appropriations bills on a timely basis, to eliminate automatic pay adjustments for Members of Congress, to prohibit the use of funds provided for the official travel expenses of Members of Congress and other officers and employees of the legislative branch for first-class airline accommodations, to establish a lifetime ban on lobbying by former Members of Congress, to prohibit consideration in the House of Representatives of measures lacking demonstrable bipartisan support, and for other purposes.
    
    Sponsor: Rep. Murphy, Stephanie N. [D-FL-7] (Introduced 05/23/2018) Cosponsors: (1)        
    
    Committees: House - House Administration, Oversight and Government Reform, Judiciary, Rules        
     Latest Action:             House - 05/23/2018 Referred to the Committee on House Administration, and in addition to the Committees on Oversight and Government Reform, the Judiciary, and Rules, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        39.
        H.R.5945 — 115th Congress (2017-2018)
    To encourage, enhance, and integrate Green Alert plans throughout the United States, and for other purposes.
    
    Sponsor: Rep. Moore, Gwen [D-WI-4] (Introduced 05/23/2018) Cosponsors: (8)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        40.
        H.R.5944 — 115th Congress (2017-2018)
    To improve career and technical education by providing improved educational opportunities and financial assistance for career and technical educators.
    
    Sponsor: Rep. Maloney, Sean Patrick [D-NY-18] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        41.
        H.R.5943 — 115th Congress (2017-2018)
    To amend the Carl D. Perkins Career and Technical Education Act of 2006 to improve professional development for career and technical educators.
    
    Sponsor: Rep. Maloney, Sean Patrick [D-NY-18] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        42.
        H.R.5942 — 115th Congress (2017-2018)
    To improve the health of minority individuals, and for other purposes.
    
    Sponsor: Rep. Lee, Barbara [D-CA-13] (Introduced 05/23/2018) Cosponsors: (57)        
    
    Committees: House - Energy and Commerce, Ways and Means, Agriculture, Education and the Workforce, Budget, Judiciary, Veterans' Affairs, Armed Services, Natural Resources        
     Latest Action:             House - 05/23/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committees on Ways and Means, Agriculture, Education and the Workforce, the Budget, the Judiciary, Veterans' Affairs, Armed Services, and Natural Resources, for a period to be subsequently... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        43.
        H.R.5941 — 115th Congress (2017-2018)
    To prevent child injuries and deaths by firearms.
    
    Sponsor: Rep. Langevin, James R. [D-RI-2] (Introduced 05/23/2018) Cosponsors: (3)        
    
    Committees: House - Judiciary, Energy and Commerce        
     Latest Action:             House - 05/23/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        44.
        H.R.5940 — 115th Congress (2017-2018)
    To require the Secretary of Defense to submit to Congress a report on victims in military criminal investigative organization reports, and for other purposes.
    
    Sponsor: Rep. Kuster, Ann M. [D-NH-2] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Armed Services        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Armed Services. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        45.
        H.R.5939 — 115th Congress (2017-2018)
    To amend the Morris K. Udall and Stewart L. Udall Foundation Act.
    
    Sponsor: Rep. Grijalva, Raul M. [D-AZ-3] (Introduced 05/23/2018) Cosponsors: (1)        
    
    Committees: House - Education and the Workforce, Natural Resources        
     Latest Action:             House - 05/23/2018 Referred to the Committee on Education and the Workforce, and in addition to the Committee on Natural Resources, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        46.
        H.R.5938 — 115th Congress (2017-2018)
    To amend the VA Choice and Quality Employment Act to direct the Secretary of Veterans Affairs to establish a vacancy and recruitment database to facilitate the recruitment of certain members of the Armed Forces to satisfy the occupational needs of the Department of Veterans Affairs, to establish and implement a training and certification program for intermediate care technicians in that Department, and for other purposes.
    
    Sponsor: Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Veterans' Affairs        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Veterans' Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        47.
        H.R.5937 — 115th Congress (2017-2018)
    To designate the facility of the United States Postal Service located at 100 Calle Alondra in San Juan, Puerto Rico, as the "65th Infantry Regiment Post Office Building".
    
    Sponsor: Rep. Gonzalez-Colon, Jenniffer [R-PR-At Large] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        48.
        H.R.5936 — 115th Congress (2017-2018)
    To amend the National Security Act of 1947 to require the appointment by the President of the Assistant to the President for National Security Affairs to be made by and with the advice and consent of the Senate.
    
    Sponsor: Rep. Foster, Bill [D-IL-11] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Armed Services, Foreign Affairs, Intelligence (Permanent Select)        
     Latest Action:             House - 05/23/2018 Referred to the Committee on Armed Services, and in addition to the Committees on Foreign Affairs, and Intelligence (Permanent Select), for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        49.
        H.R.5935 — 115th Congress (2017-2018)
    To designate the facility of the United States Postal Service located at 1355 North Meridian Road in Harristown, Illinois, as the "Logan S. Palmer Post Office".
    
    Sponsor: Rep. Davis, Rodney [R-IL-13] (Introduced 05/23/2018) Cosponsors: (17)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        50.
        H.R.5934 — 115th Congress (2017-2018)
    To designate the facility of the United States Postal Service located at 105 Highway 297 North in Dyess, Arkansas, as the "Johnny Cash Post Office Building".
    
    Sponsor: Rep. Crawford, Eric A. "Rick" [R-AR-1] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Oversight and Government Reform. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        51.
        H.R.5933 — 115th Congress (2017-2018)
    To prevent substance abuse and reduce demand for illicit narcotics.
    
    Sponsor: Rep. Collins, Doug [R-GA-9] (Introduced 05/23/2018) Cosponsors: (1)        
    
    Committees: House - Oversight and Government Reform, Judiciary, Energy and Commerce        
     Latest Action:             House - 05/23/2018 Referred to the Committee on Oversight and Government Reform, and in addition to the Committees on the Judiciary, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        52.
        H.R.5932 — 115th Congress (2017-2018)
    To increase the recruitment and retention of school-based mental health services providers by low-income local educational agencies.
    
    Sponsor: Rep. Chu, Judy [D-CA-27] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        53.
        H.R.5931 — 115th Congress (2017-2018)
    To repeal the authority to establish certain special volunteer programs under the Domestic Volunteer Service Act.
    
    Sponsor: Rep. Biggs, Andy [R-AZ-5] (Introduced 05/23/2018) Cosponsors: (0)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        54.
        H.R.5930 — 115th Congress (2017-2018)
    To strengthen protections relating to the online collection, use, and disclosure of personal information of children and minors, and for other purposes.
    
    Sponsor: Rep. Barton, Joe [R-TX-6] (Introduced 05/23/2018) Cosponsors: (1)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        55.
        H.R.5929 — 115th Congress (2017-2018)
    To amend the Small Business Act to provide for small business concerns located in the United States Virgin Islands, and for other purposes.
    
    Sponsor: Rep. Clarke, Yvette D. [D-NY-9] (Introduced 05/23/2018) Cosponsors: (2)        
    
    Committees: House - Small Business        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Small Business. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        56.
        H.R.5928 — 115th Congress (2017-2018)
    To repeal the Tax Cuts and Jobs Act, forgive all outstanding Federal student loans, and for other purposes.
    
    Sponsor: Rep. Polis, Jared [D-CO-2] (Introduced 05/23/2018) Cosponsors: (14)        
    
    Committees: House - Ways and Means, Education and the Workforce, Natural Resources, Energy and Commerce        
     Latest Action:             House - 05/23/2018 Referred to the Committee on Ways and Means, and in addition to the Committees on Education and the Workforce, Natural Resources, and Energy and Commerce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        57.
        H.R.5927 — 115th Congress (2017-2018)
    To amend the Public Health Service Act to expand, intensify, and coordinate research and other activities of the National Institutes of Health with respect to prenatal opioid exposure and neonatal abstinence syndrome.
    
    Sponsor: Rep. Soto, Darren [D-FL-9] (Introduced 05/23/2018) Cosponsors: (1)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        58.
        H.R.5926 — 115th Congress (2017-2018)
    To require the Secretary of Health and Human Services to issue guidelines for prescribing naloxone, and for other purposes.
    
    Sponsor: Rep. Keating, William R. [D-MA-9] (Introduced 05/23/2018) Cosponsors: (1)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/23/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        59.
        H.R.5925 — 115th Congress (2017-2018)
    CRISIS Act
    
    Sponsor: Rep. Gowdy, Trey [R-SC-4] (Introduced 05/23/2018) Cosponsors: (3)        
    
    Committees: House - Oversight and Government Reform, Energy and Commerce, Foreign Affairs, Judiciary, Intelligence (Permanent Select), Appropriations        
     Latest Action:             House - 05/23/2018 Ordered to be Reported (Amended) by Voice Vote. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        60.
        H.R.5924 — 115th Congress (2017-2018)
    To provide for the consideration of a definition of anti-Semitism for the enforcement of Federal antidiscrimination laws concerning education programs or activities.
    
    Sponsor: Rep. Roskam, Peter J. [R-IL-6] (Introduced 05/23/2018) Cosponsors: (12)        
    
    Committees: House - Judiciary, Education and the Workforce        
     Latest Action:             House - 05/23/2018 Referred to the Committee on the Judiciary, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-23
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        61.
        H.R.5923 — 115th Congress (2017-2018)
    To direct the Secretary of Agriculture to exchange certain public lands in Ouachita National Forest, and for other purposes.
    
    Sponsor: Rep. Westerman, Bruce [R-AR-4] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Natural Resources        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Natural Resources. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        62.
        H.R.5922 — 115th Congress (2017-2018)
    To direct the Secretary of Veterans Affairs to carry out a pilot program to increase access to hepatitis C testing for Vietnam-era veterans, and for other purposes.
    
    Sponsor: Rep. Stefanik, Elise M. [R-NY-21] (Introduced 05/22/2018) Cosponsors: (1)        
    
    Committees: House - Veterans' Affairs        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Veterans' Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        63.
        H.R.5921 — 115th Congress (2017-2018)
    To direct the Secretary of Veterans Affairs to establish a registry to ensure that members of the Armed Forces who may have been exposed to per- and polyfluoroalkyl substances on military installations receive information regarding such exposure, and for other purposes.
    
    Sponsor: Rep. Shea-Porter, Carol [D-NH-1] (Introduced 05/22/2018) Cosponsors: (3)        
    
    Committees: House - Veterans' Affairs, Armed Services        
     Latest Action:             House - 05/22/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        64.
        H.R.5920 — 115th Congress (2017-2018)
    To direct the Secretary of Veterans Affairs and the Secretary of Defense to submit to Congress an annual report on open burn pits, and for other purposes.
    
    Sponsor: Rep. Shea-Porter, Carol [D-NH-1] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Veterans' Affairs, Armed Services        
     Latest Action:             House - 05/22/2018 Referred to the Committee on Veterans' Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        65.
        H.R.5919 — 115th Congress (2017-2018)
    To establish the position of Senior Anticorruption Officer at the Department of State, the United States Agency for International Development, and the Department of Defense, and for other purposes.
    
    Sponsor: Rep. Shea-Porter, Carol [D-NH-1] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Foreign Affairs, Armed Services        
     Latest Action:             House - 05/22/2018 Referred to the Committee on Foreign Affairs, and in addition to the Committee on Armed Services, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee concerned. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        66.
        H.R.5918 — 115th Congress (2017-2018)
    To direct the Secretary of Defense to carry out a program on service dog training for members of the Armed Forces with post-traumatic stress disorder or other post-deployment mental health conditions.
    
    Sponsor: Rep. Shea-Porter, Carol [D-NH-1] (Introduced 05/22/2018) Cosponsors: (4)        
    
    Committees: House - Armed Services        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Armed Services. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        67.
        H.R.5917 — 115th Congress (2017-2018)
    To authorize the Secretary of Health and Human Services to award grants for career support for skilled, internationally educated health professionals, and for other purposes.
    
    Sponsor: Rep. Roybal-Allard, Lucille [D-CA-40] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        68.
        H.R.5916 — 115th Congress (2017-2018)
    To amend the Internal Revenue Code of 1986 to impose a tax on institutions of higher education that fail to use 33 percent of the growth in endowment value for grants for working-family students each year, and for other purposes.
    
    Sponsor: Rep. Reed, Tom [R-NY-23] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Ways and Means, Education and the Workforce        
     Latest Action:             House - 05/22/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        69.
        H.R.5915 — 115th Congress (2017-2018)
    To amend the TRIO programs to require priority to be given to homeless children and youth, and students in foster care.
    
    Sponsor: Rep. Mitchell, Paul [R-MI-10] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        70.
        H.R.5914 — 115th Congress (2017-2018)
    To require a study and report on policy and regulatory changes that may have contributed to the opioid epidemic.
    
    Sponsor: Rep. Meadows, Mark [R-NC-11] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        71.
        H.R.5913 — 115th Congress (2017-2018)
    To amend the Internal Revenue Code of 1986 to increase the limitation on the state and local tax deduction for married individuals, and for other purposes.
    
    Sponsor: Rep. MacArthur, Thomas [R-NJ-3] (Introduced 05/22/2018) Cosponsors: (1)        
    
    Committees: House - Ways and Means        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Ways and Means. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        72.
        H.R.5912 — 115th Congress (2017-2018)
    To amend title XIX of the Social Security Act to delay the reduction in Federal medical assistance percentage for Medicaid personal care services and home health services furnished without an electronic visit verification system, and for other purposes.
    
    Sponsor: Rep. Langevin, James R. [D-RI-2] (Introduced 05/22/2018) Cosponsors: (3)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        73.
        H.R.5911 — 115th Congress (2017-2018)
    To amend Public Law 115-97 (commonly known as the Tax Cuts and Jobs Act) to repeal the Arctic National Wildlife Refuge oil and gas program, and for other purposes.
    
    Sponsor: Rep. Huffman, Jared [D-CA-2] (Introduced 05/22/2018) Cosponsors: (4)        
    
    Committees: House - Natural Resources        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Natural Resources. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        74.
        H.R.5910 — 115th Congress (2017-2018)
    To strengthen the United States response to Russian interference, and for other purposes.
    
    Sponsor: Rep. Demings, Val Butler [D-FL-10] (Introduced 05/22/2018) Cosponsors: (2)        
    
    Committees: House - Foreign Affairs, Armed Services, Intelligence (Permanent Select), Oversight and Government Reform, Financial Services        
     Latest Action:             House - 05/22/2018 Referred to the Committee on Foreign Affairs, and in addition to the Committees on Armed Services, Intelligence (Permanent Select), Oversight and Government Reform, and Financial Services, for a period to be subsequently determined by the Speaker, in each case for... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        75.
        H.R.5909 — 115th Congress (2017-2018)
    To enhance reciprocal market access for United States domestic producers in the negotiating process of bilateral, regional, and multilateral trade agreements.
    
    Sponsor: Rep. DeLauro, Rosa L. [D-CT-3] (Introduced 05/22/2018) Cosponsors: (0)        
    
    Committees: House - Ways and Means        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Ways and Means. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        76.
        H.R.5908 — 115th Congress (2017-2018)
    To protect victims of crime or serious labor violations from removal during Department of Homeland Security enforcement actions, and for other purposes.
    
    Sponsor: Rep. Chu, Judy [D-CA-27] (Introduced 05/22/2018) Cosponsors: (6)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        77.
        H.R.5907 — 115th Congress (2017-2018)
    To provide directors of the National Laboratories signature authority for certain agreements, and for other purposes.
    
    Sponsor: Rep. Hultgren, Randy [R-IL-14] (Introduced 05/22/2018) Cosponsors: (11)        
    
    Committees: House - Science, Space, and Technology        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        78.
        H.R.5906 — 115th Congress (2017-2018)
    To amend the America COMPETES Act to establish Department of Energy policy for Advanced Research Projects Agency-Energy, and for other purposes.
    
    Sponsor: Rep. Lucas, Frank D. [R-OK-3] (Introduced 05/22/2018) Cosponsors: (9)        
    
    Committees: House - Science, Space, and Technology        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        79.
        H.R.5905 — 115th Congress (2017-2018)
    To authorize basic research programs in the Department of Energy Office of Science for fiscal years 2018 and 2019.
    
    Sponsor: Rep. Weber, Randy K., Sr. [R-TX-14] (Introduced 05/22/2018) Cosponsors: (11)        
    
    Committees: House - Science, Space, and Technology        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Science, Space, and Technology. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        80.
        H.R.5904 — 115th Congress (2017-2018)
    To amend the Sherman Act to make oil-producing and exporting cartels illegal.
    
    Sponsor: Rep. Chabot, Steve [R-OH-1] (Introduced 05/22/2018) Cosponsors: (5)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        81.
        H.R.5903 — 115th Congress (2017-2018)
    To amend the Internal Revenue Code of 1986 to make permanent certain changes made by Public Law 115-97 to the child tax credit.
    
    Sponsor: Rep. Smith, Jason [R-MO-8] (Introduced 05/22/2018) Cosponsors: (12)        
    
    Committees: House - Ways and Means        
     Latest Action:             House - 05/22/2018 Referred to the House Committee on Ways and Means. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-22
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        82.
        H.R.5902 — 115th Congress (2017-2018)
    To amend the Ethics in Government Act of 1978 to provide for reform in the operations of the Office of Government Ethics, and for other purposes.
    
    Sponsor: Rep. Raskin, Jamie [D-MD-8] (Introduced 05/21/2018) Cosponsors: (22)        
    
    Committees: House - Oversight and Government Reform, Judiciary        
     Latest Action:             House - 05/21/2018 Referred to the Committee on Oversight and Government Reform, and in addition to the Committee on the Judiciary, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        83.
        H.R.5901 — 115th Congress (2017-2018)
    To amend title 10, United States Code, to permit the Secretary of the Army to produce, treat, manage, and use natural gas located under Fort Knox, Kentucky, and for other purposes.
    
    Sponsor: Rep. Guthrie, Brett [R-KY-2] (Introduced 05/21/2018) Cosponsors: (0)        
    
    Committees: House - Armed Services        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Armed Services. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        84.
        H.R.5900 — 115th Congress (2017-2018)
    To provide for a national strategy to address and overcome Lyme disease and other tick-borne diseases, and for other purposes.
    
    Sponsor: Rep. Smith, Christopher H. [R-NJ-4] (Introduced 05/21/2018) Cosponsors: (6)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        85.
        H.R.5899 — 115th Congress (2017-2018)
    To amend the Public Health Service Act to reauthorize school-based health centers, and for other purposes.
    
    Sponsor: Rep. Faso, John J. [R-NY-19] (Introduced 05/21/2018) Cosponsors: (4)        
    
    Committees: House - Energy and Commerce        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Energy and Commerce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        86.
        H.R.5898 — 115th Congress (2017-2018)
    To require the Secretary of State to develop a strategy on administration policy regarding UNRWA, and for other purposes.
    
    Sponsor: Rep. Cicilline, David N. [D-RI-1] (Introduced 05/21/2018) Cosponsors: (1)        
    
    Committees: House - Foreign Affairs        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Foreign Affairs. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        87.
        H.R.5897 — 115th Congress (2017-2018)
    To require the Secretary of the Army to expedite the completion of certain feasibility studies and reports and to amend the Coastal Barrier Resources Act to ensure public safety, and for other purposes.
    
    Sponsor: Rep. Weber, Randy K., Sr. [R-TX-14] (Introduced 05/21/2018) Cosponsors: (20)        
    
    Committees: House - Transportation and Infrastructure, Natural Resources        
     Latest Action:             House - 05/21/2018 Referred to the Committee on Transportation and Infrastructure, and in addition to the Committee on Natural Resources, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        88.
        H.R.5896 — 115th Congress (2017-2018)
    To amend title 5, United States Code, to modify the authority for pay and work schedules of border patrol agents, and for other purposes.
    
    Sponsor: Rep. Hurd, Will [R-TX-23] (Introduced 05/21/2018) Cosponsors: (3)        
    
    Committees: House - Oversight and Government Reform        
     Latest Action:             House - 05/23/2018 Ordered to be Reported (Amended) by Voice Vote. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        89.
        H.R.5895 — 115th Congress (2017-2018)
    Energy and Water Development and Related Agencies Appropriations Act, 2019
    
    Sponsor: Rep. Simpson, Michael K. [R-ID-2] (Introduced 05/21/2018) Cosponsors: (0)        
    
    Committees: House - Appropriations        
     Latest Action:             House - 05/21/2018 Placed on the Union Calendar, Calendar No. 540. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-697, by Mr. Simpson.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        90.
        H.R.5894 — 115th Congress (2017-2018)
    Legislative Branch Appropriations Act, 2019
    
    Sponsor: Rep. Yoder, Kevin [R-KS-3] (Introduced 05/21/2018) Cosponsors: (0)        
    
    Committees: House - Appropriations        
    
    Committee Reports: H. Rept. 115-696 
     Latest Action:             House - 05/21/2018 Placed on the Union Calendar, Calendar No. 539. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => The House Committee on Appropriations reported an original measure, H. Rept. 115-696, by Mr. Yoder.
        [externalActionCode] => 5000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        91.
        H.R.5893 — 115th Congress (2017-2018)
    To require a certain percentage of liquefied natural gas and crude oil exports be transported on United States-built and United States-flag vessels, and for other purposes.
    
    Sponsor: Rep. Garamendi, John [D-CA-3] (Introduced 05/21/2018) Cosponsors: (3)        
    
    Committees: House - Energy and Commerce, Foreign Affairs        
     Latest Action:             House - 05/21/2018 Referred to the Committee on Energy and Commerce, and in addition to the Committee on Foreign Affairs, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the committee... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        92.
        H.R.5892 — 115th Congress (2017-2018)
    To establish an Advisory Committee on Opioids and the Workplace to advise the Secretary of Labor on actions the Department of Labor can take to address the impact of opioid abuse on the workplace.
    
    Sponsor: Rep. Lewis, Jason [R-MN-2] (Introduced 05/21/2018) Cosponsors: (1)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        93.
        H.R.5891 — 115th Congress (2017-2018)
    To establish an interagency task force to improve the Federal response to families impacted by substance abuse disorders.
    
    Sponsor: Rep. Grothman, Glenn [R-WI-6] (Introduced 05/21/2018) Cosponsors: (2)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        94.
        H.R.5890 — 115th Congress (2017-2018)
    To require the Secretary of Health and Human Services to provide assistance to States in complying with, and implementing, certain provisions of section 106 of the Child Abuse Prevention and Treatment Act in order to promote better protections for young children and family-centered responses, and for other purposes.
    
    Sponsor: Rep. Garrett, Thomas A., Jr. [R-VA-5] (Introduced 05/21/2018) Cosponsors: (1)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        95.
        H.R.5889 — 115th Congress (2017-2018)
    To require the Secretary of Health and Human Services to disseminate information, resources, and if requested, technical assistance to early childhood care and education providers and professionals working with young children on ways to properly recognize and respond to children who may be impacted by trauma related to substance abuse.
    
    Sponsor: Rep. Brat, Dave [R-VA-7] (Introduced 05/21/2018) Cosponsors: (2)        
    
    Committees: House - Education and the Workforce        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on Education and the Workforce. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        96.
        H.R.5888 — 115th Congress (2017-2018)
    To amend part A of title IV of the Social Security Act to provide grants for coordination of the TANF program with career pathways.
    
    Sponsor: Rep. Neal, Richard E. [D-MA-1] (Introduced 05/21/2018) Cosponsors: (14)        
    
    Committees: House - Ways and Means, Education and the Workforce        
     Latest Action:             House - 05/21/2018 Referred to the Committee on Ways and Means, and in addition to the Committee on Education and the Workforce, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        97.
        H.R.5887 — 115th Congress (2017-2018)
    To amend the Leahy-Smith America Invents Act to extend the period during which the Under Secretary of Commerce for Intellectual Property and Director of the United States Patent and Trademark Office may set or adjust certain fees, and for other purposes.
    
    Sponsor: Rep. Chabot, Steve [R-OH-1] (Introduced 05/21/2018) Cosponsors: (1)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/21/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-21
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        98.
        H.R.5886 — 115th Congress (2017-2018)
    To apply the Bank Secrecy Act to dealers in art or antiquities.
    
    Sponsor: Rep. Messer, Luke [R-IN-6] (Introduced 05/18/2018) Cosponsors: (0)        
    
    Committees: House - Financial Services        
     Latest Action:             House - 05/18/2018 Referred to the House Committee on Financial Services. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        99.
        H.R.5885 — 115th Congress (2017-2018)
    To reauthorize the Partners for Fish and Wildlife Program and certain wildlife conservation funds, to establish prize competitions relating to the prevention of wildlife poaching and trafficking, wildlife conservation, the management of invasive species, and the protection of endangered species, and for other purposes.
    
    Sponsor: Rep. Lowenthal, Alan S. [D-CA-47] (Introduced 05/18/2018) Cosponsors: (1)        
    
    Committees: House - Natural Resources, Science, Space, and Technology        
     Latest Action:             House - 05/18/2018 Referred to the Committee on Natural Resources, and in addition to the Committee on Science, Space, and Technology, for a period to be subsequently determined by the Speaker, in each case for consideration of such provisions as fall within the jurisdiction of the... (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    
    ===================
     BILL
        100.
        H.R.5884 — 115th Congress (2017-2018)
    To amend title 18, United States Code, to punish unlawful obstruction of the enforcement of the laws of the United States by State officials, and for other purposes.
    
    Sponsor: Rep. King, Steve [R-IA-4] (Introduced 05/18/2018) Cosponsors: (1)        
    
    Committees: House - Judiciary        
     Latest Action:             House - 05/18/2018 Referred to the House Committee on the Judiciary. (All Actions)        
    
                Tracker: This bill has the status IntroducedHere are the steps for Status of Legislation:IntroducedArray
    (
        [actionDate] => 2018-05-18
        [displayText] => Introduced in House
        [externalActionCode] => 1000
        [description] => Introduced
    )
    Passed HousePassed SenateTo PresidentBecame Law 
    


## Extracting pertinent information

Test parsing with the first list item - then you can do the same for all the list items:


```python
# Take the first <li> object
result = ordered.find('li')
```


```python
result
```




    <li class="expanded"> <div><span class="visualIndicator">BILL</span></div>
        1.
        <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5983?r=1">H.R.5983</a> — 115th Congress (2017-2018)</span>
    <span class="result-title">To amend the Communications Act of 1934 to require providers of a covered service to provide location information concerning the telecommunications device of a user of such service to an investigative or law enforcement officer or an employee or other agent of a public safety answering point in an emergency situation involving risk of death or serious physical harm or in order to respond to the user's call for emergency services.</span>
    <span class="result-item">
    <strong>Sponsor:</strong> <a href="/member/kevin-yoder/Y000063" target="_blank">Rep. Yoder, Kevin [R-KS-3]</a> (Introduced 05/25/2018) <strong>Cosponsors:</strong> (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5983/cosponsors?r=1&amp;overview=closed#tabs">2</a>)        </span>
    <span class="result-item">
    <strong>Committees:</strong> House - Energy and Commerce        </span>
    <span class="result-item"><strong> Latest Action:            </strong> House - 05/25/2018 Referred to the House Committee on Energy and Commerce. (<a href="https://www.congress.gov/bill/115th-congress/house-bill/5983/all-actions?r=1&amp;overview=closed#tabs">All Actions</a>)        </span>
    <span class="result-item result-tracker"><strong>
                Tracker: </strong><p class="hide_fromsighted">This bill has the status Introduced</p><p class="hide_fromsighted">Here are the steps for Status of Legislation:</p><ol class="stat_leg"><li class="first selected">Introduced<div class="sol-step-info" style="display:none">Array
    (
        [actionDate] =&gt; 2018-05-25
        [displayText] =&gt; Introduced in House
        [externalActionCode] =&gt; 1000
        [description] =&gt; Introduced
    )
    </div></li><li>Passed House</li><li>Passed Senate</li><li>To President</li><li class="last">Became Law</li></ol> </span>
    </li>




```python
result.find('span').text
```




    'BILL'




```python
heading = result.find('span', attrs={'class':'result-heading'})
heading
```




    <span class="result-heading"><a href="https://www.congress.gov/bill/115th-congress/house-bill/5983?r=1">H.R.5983</a> — 115th Congress (2017-2018)</span>




```python
heading.find('a').text
```




    'H.R.5983'




```python
heading.find('a').attrs
```




    {'href': 'https://www.congress.gov/bill/115th-congress/house-bill/5983?r=1'}




```python
heading.find('a').attrs['href']
```




    'https://www.congress.gov/bill/115th-congress/house-bill/5983?r=1'




```python
title = result.find('span', attrs={'class':'result-title'})
title.text
```




    "To amend the Communications Act of 1934 to require providers of a covered service to provide location information concerning the telecommunications device of a user of such service to an investigative or law enforcement officer or an employee or other agent of a public safety answering point in an emergency situation involving risk of death or serious physical harm or in order to respond to the user's call for emergency services."



Possible info to extract:

- Name
- URL
- Bill status
- Bill number
- Sponsors
- Date / Congress
- Committees
- House

Putting it together into a DataFrame.

- Loop across elements, saving the extracted info into a lists of values


```python
all_rows = []
for result in ordered.find_all('li', attrs={'class':'expanded'}):
    type_info = result.find('span').text
    heading = result.find('span', attrs={'class':'result-heading'})
    bill_no = heading.find('a').text
    url = heading.find('a').attrs['href']
    title =result.find('span', attrs={'class':'result-title'}).text
    
    row = [type_info, bill_no, url, title]
    all_rows.append(row)
```


```python
import pandas as pd
pd.DataFrame(all_rows, columns=['type', 'billno', 'url', 'title'])
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>type</th>
      <th>billno</th>
      <th>url</th>
      <th>title</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>BILL</td>
      <td>H.R.5983</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend the Communications Act of 1934 to req...</td>
    </tr>
    <tr>
      <th>1</th>
      <td>BILL</td>
      <td>H.R.5982</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend title 5, United States Code, to incre...</td>
    </tr>
    <tr>
      <th>2</th>
      <td>BILL</td>
      <td>H.R.5981</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend title 44, United States Code, to proh...</td>
    </tr>
    <tr>
      <th>3</th>
      <td>BILL</td>
      <td>H.R.5980</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To authorize, develop, and implement a coordin...</td>
    </tr>
    <tr>
      <th>4</th>
      <td>BILL</td>
      <td>H.R.5979</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To establish the Mill Springs Battlefield Nati...</td>
    </tr>
    <tr>
      <th>5</th>
      <td>BILL</td>
      <td>H.R.5978</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend the Food Security Act of 1985 to prov...</td>
    </tr>
    <tr>
      <th>6</th>
      <td>BILL</td>
      <td>H.R.5977</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To improve Federal efforts with respect to the...</td>
    </tr>
    <tr>
      <th>7</th>
      <td>BILL</td>
      <td>H.R.5976</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend the Individuals with Disabilities Edu...</td>
    </tr>
    <tr>
      <th>8</th>
      <td>BILL</td>
      <td>H.R.5975</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To support businesses in Puerto Rico, extend c...</td>
    </tr>
    <tr>
      <th>9</th>
      <td>BILL</td>
      <td>H.R.5974</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To direct the Secretary of Veterans Affairs to...</td>
    </tr>
    <tr>
      <th>10</th>
      <td>BILL</td>
      <td>H.R.5973</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend the Robert T. Stafford Disaster Relie...</td>
    </tr>
    <tr>
      <th>11</th>
      <td>BILL</td>
      <td>H.R.5972</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend section 502 of title 40, United State...</td>
    </tr>
    <tr>
      <th>12</th>
      <td>BILL</td>
      <td>H.R.5971</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To include nonprofit and volunteer ground and ...</td>
    </tr>
    <tr>
      <th>13</th>
      <td>BILL</td>
      <td>H.R.5970</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To require the Securities and Exchange Commiss...</td>
    </tr>
    <tr>
      <th>14</th>
      <td>BILL</td>
      <td>H.R.5969</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To prohibit the use of Federal funds for the p...</td>
    </tr>
    <tr>
      <th>15</th>
      <td>BILL</td>
      <td>H.R.5968</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To encourage online workforce training.</td>
    </tr>
    <tr>
      <th>16</th>
      <td>BILL</td>
      <td>H.R.5967</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To establish a single export promotion agency ...</td>
    </tr>
    <tr>
      <th>17</th>
      <td>BILL</td>
      <td>H.R.5966</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To improve the provision of health care for wo...</td>
    </tr>
    <tr>
      <th>18</th>
      <td>BILL</td>
      <td>H.R.5965</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To require health insurance coverage for the t...</td>
    </tr>
    <tr>
      <th>19</th>
      <td>BILL</td>
      <td>H.R.5964</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend the Professional Boxing Safety Act of...</td>
    </tr>
    <tr>
      <th>20</th>
      <td>BILL</td>
      <td>H.R.5963</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To delay the reimposition of the annual fee on...</td>
    </tr>
    <tr>
      <th>21</th>
      <td>BILL</td>
      <td>H.R.5962</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To provide for loan forgiveness for STEM teach...</td>
    </tr>
    <tr>
      <th>22</th>
      <td>BILL</td>
      <td>H.R.5961</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>Making appropriations for Agriculture, Rural D...</td>
    </tr>
    <tr>
      <th>23</th>
      <td>BILL</td>
      <td>H.R.5960</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To direct the Attorney General to make grants ...</td>
    </tr>
    <tr>
      <th>24</th>
      <td>BILL</td>
      <td>H.R.5959</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To promote national security and jobs through ...</td>
    </tr>
    <tr>
      <th>25</th>
      <td>BILL</td>
      <td>H.R.5958</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend title XVIII of the Social Security Ac...</td>
    </tr>
    <tr>
      <th>26</th>
      <td>BILL</td>
      <td>H.R.5957</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To establish the Caddo Lake National Heritage ...</td>
    </tr>
    <tr>
      <th>27</th>
      <td>BILL</td>
      <td>H.R.5956</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To incentivize the hiring of United States wor...</td>
    </tr>
    <tr>
      <th>28</th>
      <td>BILL</td>
      <td>H.R.5955</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To reauthorize subtitle A of the Victims of Ch...</td>
    </tr>
    <tr>
      <th>29</th>
      <td>BILL</td>
      <td>H.R.5954</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend title 18, United States Code, to clar...</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>70</th>
      <td>BILL</td>
      <td>H.R.5913</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend the Internal Revenue Code of 1986 to ...</td>
    </tr>
    <tr>
      <th>71</th>
      <td>BILL</td>
      <td>H.R.5912</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend title XIX of the Social Security Act ...</td>
    </tr>
    <tr>
      <th>72</th>
      <td>BILL</td>
      <td>H.R.5911</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend Public Law 115-97 (commonly known as ...</td>
    </tr>
    <tr>
      <th>73</th>
      <td>BILL</td>
      <td>H.R.5910</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To strengthen the United States response to Ru...</td>
    </tr>
    <tr>
      <th>74</th>
      <td>BILL</td>
      <td>H.R.5909</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To enhance reciprocal market access for United...</td>
    </tr>
    <tr>
      <th>75</th>
      <td>BILL</td>
      <td>H.R.5908</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To protect victims of crime or serious labor v...</td>
    </tr>
    <tr>
      <th>76</th>
      <td>BILL</td>
      <td>H.R.5907</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To provide directors of the National Laborator...</td>
    </tr>
    <tr>
      <th>77</th>
      <td>BILL</td>
      <td>H.R.5906</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend the America COMPETES Act to establish...</td>
    </tr>
    <tr>
      <th>78</th>
      <td>BILL</td>
      <td>H.R.5905</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To authorize basic research programs in the De...</td>
    </tr>
    <tr>
      <th>79</th>
      <td>BILL</td>
      <td>H.R.5904</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend the Sherman Act to make oil-producing...</td>
    </tr>
    <tr>
      <th>80</th>
      <td>BILL</td>
      <td>H.R.5903</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend the Internal Revenue Code of 1986 to ...</td>
    </tr>
    <tr>
      <th>81</th>
      <td>BILL</td>
      <td>H.R.5902</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend the Ethics in Government Act of 1978 ...</td>
    </tr>
    <tr>
      <th>82</th>
      <td>BILL</td>
      <td>H.R.5901</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend title 10, United States Code, to perm...</td>
    </tr>
    <tr>
      <th>83</th>
      <td>BILL</td>
      <td>H.R.5900</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To provide for a national strategy to address ...</td>
    </tr>
    <tr>
      <th>84</th>
      <td>BILL</td>
      <td>H.R.5899</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend the Public Health Service Act to reau...</td>
    </tr>
    <tr>
      <th>85</th>
      <td>BILL</td>
      <td>H.R.5898</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To require the Secretary of State to develop a...</td>
    </tr>
    <tr>
      <th>86</th>
      <td>BILL</td>
      <td>H.R.5897</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To require the Secretary of the Army to expedi...</td>
    </tr>
    <tr>
      <th>87</th>
      <td>BILL</td>
      <td>H.R.5896</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend title 5, United States Code, to modif...</td>
    </tr>
    <tr>
      <th>88</th>
      <td>BILL</td>
      <td>H.R.5895</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>Energy and Water Development and Related Agenc...</td>
    </tr>
    <tr>
      <th>89</th>
      <td>BILL</td>
      <td>H.R.5894</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>Legislative Branch Appropriations Act, 2019</td>
    </tr>
    <tr>
      <th>90</th>
      <td>BILL</td>
      <td>H.R.5893</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To require a certain percentage of liquefied n...</td>
    </tr>
    <tr>
      <th>91</th>
      <td>BILL</td>
      <td>H.R.5892</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To establish an Advisory Committee on Opioids ...</td>
    </tr>
    <tr>
      <th>92</th>
      <td>BILL</td>
      <td>H.R.5891</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To establish an interagency task force to impr...</td>
    </tr>
    <tr>
      <th>93</th>
      <td>BILL</td>
      <td>H.R.5890</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To require the Secretary of Health and Human S...</td>
    </tr>
    <tr>
      <th>94</th>
      <td>BILL</td>
      <td>H.R.5889</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To require the Secretary of Health and Human S...</td>
    </tr>
    <tr>
      <th>95</th>
      <td>BILL</td>
      <td>H.R.5888</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend part A of title IV of the Social Secu...</td>
    </tr>
    <tr>
      <th>96</th>
      <td>BILL</td>
      <td>H.R.5887</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend the Leahy-Smith America Invents Act t...</td>
    </tr>
    <tr>
      <th>97</th>
      <td>BILL</td>
      <td>H.R.5886</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To apply the Bank Secrecy Act to dealers in ar...</td>
    </tr>
    <tr>
      <th>98</th>
      <td>BILL</td>
      <td>H.R.5885</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To reauthorize the Partners for Fish and Wildl...</td>
    </tr>
    <tr>
      <th>99</th>
      <td>BILL</td>
      <td>H.R.5884</td>
      <td>https://www.congress.gov/bill/115th-congress/h...</td>
      <td>To amend title 18, United States Code, to puni...</td>
    </tr>
  </tbody>
</table>
<p>100 rows × 4 columns</p>
</div>



## Exercises

- Scrape the calendar from https://morgridge.du.edu
  - How would you gather the information from the details page?

## Pandas


```python
df = pd.read_csv('../data/weather-example.csv')
df.head(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>STATION</th>
      <th>NAME</th>
      <th>DATE</th>
      <th>PRCP</th>
      <th>SNOW</th>
      <th>SNWD</th>
      <th>TMAX</th>
      <th>TMIN</th>
      <th>TOBS</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/22/2017</td>
      <td>0.08</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>67</td>
      <td>42</td>
      <td>42</td>
    </tr>
    <tr>
      <th>1</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/23/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>63</td>
      <td>39</td>
      <td>48</td>
    </tr>
    <tr>
      <th>2</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/24/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>83</td>
      <td>40</td>
      <td>62</td>
    </tr>
    <tr>
      <th>3</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/25/2017</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>76</td>
      <td>51</td>
      <td>52</td>
    </tr>
    <tr>
      <th>4</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/26/2017</td>
      <td>0.37</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>71</td>
      <td>42</td>
      <td>51</td>
    </tr>
    <tr>
      <th>5</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/27/2017</td>
      <td>0.17</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>59</td>
      <td>46</td>
      <td>47</td>
    </tr>
    <tr>
      <th>6</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/28/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>72</td>
      <td>43</td>
      <td>53</td>
    </tr>
    <tr>
      <th>7</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/29/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>69</td>
      <td>47</td>
      <td>53</td>
    </tr>
    <tr>
      <th>8</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/30/2017</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>76</td>
      <td>47</td>
      <td>56</td>
    </tr>
    <tr>
      <th>9</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/31/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>82</td>
      <td>48</td>
      <td>61</td>
    </tr>
  </tbody>
</table>
</div>




```python
%matplotlib inline
df.plot(x='DATE', y='TMAX')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1ac1f2953c8>




![png](output_59_1.png)


## Rolling means

Column:

```
df.columnName.rolling(window, min_periods=None, on=None, axis=0, closed=None)
```


```python
df.TMAX.rolling(window=7).mean()
```




    0            NaN
    1            NaN
    2            NaN
    3            NaN
    4            NaN
    5            NaN
    6      70.142857
    7      70.428571
    8      72.285714
    9      72.142857
    10     72.857143
    11     73.714286
    12     76.142857
    13     77.714286
    14     79.571429
    15     79.714286
    16     80.285714
    17     82.000000
    18     84.571429
    19     86.714286
    20     86.285714
    21     86.857143
    22     88.428571
    23     89.428571
    24     88.285714
    25     86.857143
    26     86.285714
    27     88.857143
    28     90.285714
    29     90.571429
             ...    
    153    59.000000
    154    56.428571
    155    56.285714
    156    54.000000
    157    50.571429
    158    51.428571
    159    51.714286
    160    50.142857
    161    53.000000
    162    57.000000
    163    59.571429
    164    64.142857
    165    65.142857
    166    63.714286
    167    64.428571
    168    63.714286
    169    62.000000
    170    64.285714
    171    63.428571
    172    64.428571
    173    66.285714
    174    67.857143
    175    69.285714
    176    68.000000
    177    67.571429
    178    65.285714
    179    64.142857
    180    64.714286
    181    64.000000
    182    59.857143
    Name: TMAX, Length: 183, dtype: float64



Easier to compare as a new column of the DataFrame:


```python
df['rolling_max'] = df.TMAX.rolling(window=7).mean()
df.head(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>STATION</th>
      <th>NAME</th>
      <th>DATE</th>
      <th>PRCP</th>
      <th>SNOW</th>
      <th>SNWD</th>
      <th>TMAX</th>
      <th>TMIN</th>
      <th>TOBS</th>
      <th>rolling_max</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/22/2017</td>
      <td>0.08</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>67</td>
      <td>42</td>
      <td>42</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/23/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>63</td>
      <td>39</td>
      <td>48</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/24/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>83</td>
      <td>40</td>
      <td>62</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/25/2017</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>76</td>
      <td>51</td>
      <td>52</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/26/2017</td>
      <td>0.37</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>71</td>
      <td>42</td>
      <td>51</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/27/2017</td>
      <td>0.17</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>59</td>
      <td>46</td>
      <td>47</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/28/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>72</td>
      <td>43</td>
      <td>53</td>
      <td>70.142857</td>
    </tr>
    <tr>
      <th>7</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/29/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>69</td>
      <td>47</td>
      <td>53</td>
      <td>70.428571</td>
    </tr>
    <tr>
      <th>8</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/30/2017</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>76</td>
      <td>47</td>
      <td>56</td>
      <td>72.285714</td>
    </tr>
    <tr>
      <th>9</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/31/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>82</td>
      <td>48</td>
      <td>61</td>
      <td>72.142857</td>
    </tr>
  </tbody>
</table>
</div>




```python
df['rolling_max'] = df.TMAX.rolling(window=7, min_periods=1).mean()
df.head(15)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>STATION</th>
      <th>NAME</th>
      <th>DATE</th>
      <th>PRCP</th>
      <th>SNOW</th>
      <th>SNWD</th>
      <th>TMAX</th>
      <th>TMIN</th>
      <th>TOBS</th>
      <th>rolling_max</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/22/2017</td>
      <td>0.08</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>67</td>
      <td>42</td>
      <td>42</td>
      <td>67.000000</td>
    </tr>
    <tr>
      <th>1</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/23/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>63</td>
      <td>39</td>
      <td>48</td>
      <td>65.000000</td>
    </tr>
    <tr>
      <th>2</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/24/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>83</td>
      <td>40</td>
      <td>62</td>
      <td>71.000000</td>
    </tr>
    <tr>
      <th>3</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/25/2017</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>76</td>
      <td>51</td>
      <td>52</td>
      <td>72.250000</td>
    </tr>
    <tr>
      <th>4</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/26/2017</td>
      <td>0.37</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>71</td>
      <td>42</td>
      <td>51</td>
      <td>72.000000</td>
    </tr>
    <tr>
      <th>5</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/27/2017</td>
      <td>0.17</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>59</td>
      <td>46</td>
      <td>47</td>
      <td>69.833333</td>
    </tr>
    <tr>
      <th>6</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/28/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>72</td>
      <td>43</td>
      <td>53</td>
      <td>70.142857</td>
    </tr>
    <tr>
      <th>7</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/29/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>69</td>
      <td>47</td>
      <td>53</td>
      <td>70.428571</td>
    </tr>
    <tr>
      <th>8</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/30/2017</td>
      <td>0.03</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>76</td>
      <td>47</td>
      <td>56</td>
      <td>72.285714</td>
    </tr>
    <tr>
      <th>9</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/31/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>82</td>
      <td>48</td>
      <td>61</td>
      <td>72.142857</td>
    </tr>
    <tr>
      <th>10</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>6/1/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>81</td>
      <td>52</td>
      <td>62</td>
      <td>72.857143</td>
    </tr>
    <tr>
      <th>11</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>6/2/2017</td>
      <td>0.19</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>77</td>
      <td>55</td>
      <td>58</td>
      <td>73.714286</td>
    </tr>
    <tr>
      <th>12</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>6/3/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>76</td>
      <td>52</td>
      <td>61</td>
      <td>76.142857</td>
    </tr>
    <tr>
      <th>13</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>6/4/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>83</td>
      <td>53</td>
      <td>65</td>
      <td>77.714286</td>
    </tr>
    <tr>
      <th>14</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>6/5/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>82</td>
      <td>57</td>
      <td>60</td>
      <td>79.571429</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.plot(x='DATE', y='TMAX')
df.plot(x='DATE', y='rolling_max')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1ac21737128>




![png](output_65_1.png)



![png](output_65_2.png)



```python
df['2week-avgmax'] = df.TMAX.rolling(window=7*4, min_periods=1).mean()
df.plot(x='DATE', y='2week-avgmax')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1ac224f3748>




![png](output_66_1.png)


## Data types

Pandas tries to figure out the datatype automatically: integer, float, string, object (i.e. mix of various), boolean.


```python
df.dtypes
```




    STATION         object
    NAME            object
    DATE            object
    PRCP           float64
    SNOW           float64
    SNWD           float64
    TMAX             int64
    TMIN             int64
    TOBS             int64
    rolling_max    float64
    2week-avg      float64
    dtype: object



## Working with dates and time

The 'Date' column is not recognized as dates. Convert it with `pd.to_datetime(column)` -- Then Pandas can work more smartly.

Here's some fake data, with 5 data points from May and 5 from July:


```python
fake_data = pd.concat([df[0:5], df[40:45]])
print(fake_data[['DATE', 'TMAX']][3:7])
fake_data.plot(x='DATE', y='TMAX')
```

             DATE  TMAX
    3   5/25/2017    76
    4   5/26/2017    71
    40   7/4/2017    92
    41   7/5/2017    98





    <matplotlib.axes._subplots.AxesSubplot at 0x1ac2257c160>




![png](output_71_2.png)


#### Problem: *Since Pandas doesn't realize that 'DATE' is a date column, it doesn't show the proper spacing between 5/26 and 7/4*

### `pd.to_datetime()`

The following will convert the generic 'object' datatype of the DATE column into a 'datetime' datatype:


```python
pd.to_datetime(df.DATE).head()
```




    0   2017-05-22
    1   2017-05-23
    2   2017-05-24
    3   2017-05-25
    4   2017-05-26
    Name: DATE, dtype: datetime64[ns]



Set it to a new column, or overwrite the existing column. Here, I'm setting to 'new_date' for clarity.


```python
df['new_date'] = pd.to_datetime(df.DATE)
df.head(2)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>STATION</th>
      <th>NAME</th>
      <th>DATE</th>
      <th>PRCP</th>
      <th>SNOW</th>
      <th>SNWD</th>
      <th>TMAX</th>
      <th>TMIN</th>
      <th>TOBS</th>
      <th>rolling_max</th>
      <th>2week-avg</th>
      <th>new_date</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/22/2017</td>
      <td>0.08</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>67</td>
      <td>42</td>
      <td>42</td>
      <td>67.0</td>
      <td>67.0</td>
      <td>2017-05-22</td>
    </tr>
    <tr>
      <th>1</th>
      <td>USC00052228</td>
      <td>DENVER MUSEUM, CO US</td>
      <td>5/23/2017</td>
      <td>0.00</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>63</td>
      <td>39</td>
      <td>48</td>
      <td>65.0</td>
      <td>65.0</td>
      <td>2017-05-23</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.dtypes
```




    STATION                object
    NAME                   object
    DATE                   object
    PRCP                  float64
    SNOW                  float64
    SNWD                  float64
    TMAX                    int64
    TMIN                    int64
    TOBS                    int64
    rolling_max           float64
    2week-avg             float64
    new_date       datetime64[ns]
    dtype: object




```python
fake_data = pd.concat([df[0:5], df[40:45]])
print(fake_data[['DATE', 'new_date', 'TMAX']][3:7])
fake_data.plot(x='new_date', y='TMAX')
```

             DATE   new_date  TMAX
    3   5/25/2017 2017-05-25    76
    4   5/26/2017 2017-05-26    71
    40   7/4/2017 2017-07-04    92
    41   7/5/2017 2017-07-05    98





    <matplotlib.axes._subplots.AxesSubplot at 0x1ac2373acf8>




![png](output_78_2.png)


## Better!

With a proper data column:
    
- `rolling` will be more accurate, especially with less neat intervals than our weather data
  - e.g. `df.col1.rolling('2w')`, `df.col1.rolling('20m')`
- Can select substrings by date
  - e.g. return June 2017 - Sept 2017
- Proper intervals in plots
- Easy conversion of timezones
- Easy convert from datetime field to custom strings; by month, or year, or minute, etc.

Documentation: [Time Series / Date functionality](http://pandas.pydata.org/pandas-docs/stable/timeseries.html)

## Pandas <-> SQL Skills Transfer

[Pandas Documentation: Comparison with SQL](http://pandas.pydata.org/pandas-docs/stable/comparison_with_sql.html)

![](../images/sql-skills.png)

# Thank you
