20190205(화)

flutter 에서 레이아웃 관련 정리
    - 믿음교구 출석 앱을 구성하려고 하는데 어떻게 레이아웃을 설계해야할지 고민하다가 먼저 이 부분을 살펴보게 됨

https://flutter.io/docs/development/ui/widgets-intro
// Widgets describe what their view should look like given their current configuration and state
// Passing widgets as arguments to other widgets is a powerful technique that lets you create generic widgets that can be reused in a wide variety of ways.

20190206(수)

어떤 애들을 사용해서 출석화면을 구성할지 찾아보고 실제로 적용해보기

// 어떤 애들을 사용할지.. 결정 material 
https://flutter.io/docs/development/ui/widgets/material

// data table (listview 대신에 적용해도 괜춘을 듯)
https://material.io/design/components/data-tables.html#

https://material.io/design/components/selection-controls.html#checkboxes


가장 중요한? 부분이 ... 출석부의 각... <event, boolean> 정보를 어떻게 잘 표현할지??

// 
https://flutter.io/docs/cookbook/networking/background-parsing

//
https://flutter.io/docs/cookbook/design/fonts
https://flutter.io/docs/cookbook/design/themes


https://flutter.io/docs/cookbook/networking/background-parsing
https://jsonplaceholder.typicode.com/photos


// samples
https://github.com/flutter/samples/blob/master/INDEX.md



// 
https://material.io/design/


// 
https://flutter.io/docs/resources/bootstrap-into-dart

// UI관련 개념
https://flutter.io/docs/development/ui/layout
https://flutter.io/docs/development/ui/widgets-intro
https://flutter.io/docs/development/ui/layout/tutorial


// http
https://pub.dartlang.org/documentation/http/latest/http/http-library.html
https://pub.dartlang.org/packages/http

20190207 (목)

attendancebook 화면 구성
    - 화면 비율... (에고.. data-table 에서 크기를 밖에서 조정할 길이 없는듯.. 그러면 코드를 직접 고쳐야하나...)
        아마... data_table.dart 에서 크기 관련 항목들을 수정해야 할듯.. ㅠㅠ 
        어떻게하면 event들이 추가되어도 확인 가능하게 할 수 있으려나??

        * 나만의 flutter 소스가 아니라... 다른 곳에서도 적용되었으면 하는데 ...
        (flutter의 코드를 고치면 빌드하면 상관 없는건지.. 다른곳에서는 문제가 되는건지...)

        

    - 총계 + 전송 부분 추가 (화면에서 어떻게 구상할지도.. 고려해야할 듯)
    


// 
https://flutter.io/docs/development/ui/layout