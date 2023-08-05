$(document).ready(function ( ) {
    document.querySelectorAll(".goods_Lcategory > div").forEach(lcategory => {
        lcategory.addEventListener("click", function() {
            document.querySelectorAll("div[class^='goods_Mcategory'] > div").forEach(mcategory => {
                mcategory.classList.remove("selected");
            });	
            document.querySelectorAll("div[class^='goods_Scategory'] > div").forEach(scategory => {
                scategory.classList.remove("selected");
                scategory.classList.add("hidden");
            });	
            document.querySelectorAll(".goods_Lcategory > div").forEach(sib => {
                sib.removeAttribute("class");
            });
            this.setAttribute("class", "selected");
            document.querySelector(".goods_category").style.borderColor="rgb(245, 126, 0)";
            document.querySelector(".goods_category + p").classList.remove("hidden");
            
            document.querySelector("div.goods_Mcategory").classList.add("hidden");
            document.querySelector("div.goods_Scategory").classList.add("hidden");

            if(lcategory.innerText === "패션/의류"){
				document.querySelector("div.goods_Mcategory_acc").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_hobby").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_digital").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_sports").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_beauty").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_life").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_car").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_book").classList.add("hidden");
                const classList = document.querySelector("div.goods_Mcategory_cloth").classList;
                classList.remove("hidden");
            } 
            else if(lcategory.innerText === "패션/잡화"){
                document.querySelector("div.goods_Mcategory_cloth").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_hobby").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_digital").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_sports").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_beauty").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_life").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_car").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_book").classList.add("hidden");
                const classList = document.querySelector("div.goods_Mcategory_acc").classList;
                classList.remove("hidden");
            }
            else if(lcategory.innerText === "취미/컬렉션"){
                document.querySelector("div.goods_Mcategory_cloth").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_acc").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_digital").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_sports").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_beauty").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_life").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_car").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_book").classList.add("hidden");
                const classList = document.querySelector("div.goods_Mcategory_hobby").classList;
                classList.remove("hidden");
            }
            else if(lcategory.innerText === "디지털"){
                document.querySelector("div.goods_Mcategory_cloth").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_acc").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_hobby").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_sports").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_beauty").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_life").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_car").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_book").classList.add("hidden");
                const classList = document.querySelector("div.goods_Mcategory_digital").classList;
                classList.remove("hidden");
            }
            else if(lcategory.innerText === "스포츠/레저"){
                document.querySelector("div.goods_Mcategory_cloth").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_acc").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_hobby").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_digital").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_beauty").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_life").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_car").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_book").classList.add("hidden");
                const classList = document.querySelector("div.goods_Mcategory_sports").classList;
                classList.remove("hidden");
            }
            else if(lcategory.innerText === "뷰티"){
               	document.querySelector("div.goods_Mcategory_cloth").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_acc").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_hobby").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_digital").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_sports").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_life").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_car").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_book").classList.add("hidden");
                const classList = document.querySelector("div.goods_Mcategory_beauty").classList;
                classList.remove("hidden");
            }
            else if(lcategory.innerText === "생활가전"){
                document.querySelector("div.goods_Mcategory_cloth").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_acc").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_hobby").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_digital").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_sports").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_beauty").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_car").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_book").classList.add("hidden");
                const classList = document.querySelector("div.goods_Mcategory_life").classList;
                classList.remove("hidden");
            }
            else if(lcategory.innerText === "자동차/공구"){
                document.querySelector("div.goods_Mcategory_cloth").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_acc").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_hobby").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_digital").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_sports").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_beauty").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_life").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_book").classList.add("hidden");
                const classList = document.querySelector("div.goods_Mcategory_car").classList;
                classList.remove("hidden");
            }
            else if(lcategory.innerText === "도서/기타"){
                document.querySelector("div.goods_Mcategory_cloth").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_acc").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_hobby").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_digital").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_sports").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_beauty").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_life").classList.add("hidden");
				document.querySelector("div.goods_Mcategory_car").classList.add("hidden");
                const classList = document.querySelector("div.goods_Mcategory_book").classList;
                classList.remove("hidden");
            }

            document.querySelector(".goods_category_area span.selected_category").innerText = this.innerText;
        });
    });

    document.querySelectorAll("div[class^='goods_Mcategory'] > div").forEach(mcategory => {
        mcategory.addEventListener("click", function() {
            const children = this.parentElement.children
            for (let i = 0; i < children.length; i++) {
                children[i].removeAttribute("class");
            }
            this.classList.add("selected");
            document.querySelectorAll("div[class^='goods_Scategory'] > div").forEach(scategory => {
                scategory.classList.remove("selected");
            });
            
            document.querySelectorAll("div[class^='goods_Scategory'] > div").forEach(scategory => {
                scategory.classList.remove("hidden");
            });

            document.querySelector(".goods_category").style.borderColor="rgb(220, 219, 228)";
            document.querySelector(".goods_category + p").classList.add("hidden");
            
            if(mcategory.innerText === "남성의류"){
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_clothA").classList;
                classList.remove("hidden");
            } 
            else if(mcategory.innerText === "여성의류"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_clothB").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "언더웨어"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_clothC").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "신발"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_accA").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "가방/잡화"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_accB").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "쥬얼리/시계"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_accC").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "수입명품"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_accD").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "반려동물용품"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_hobbyA").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "악기/취미"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_hobbyB").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "문구/사무용품"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_hobbyC").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "꽃/이벤트용품"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_hobbyD").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "노트북/데스크탑"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_digitalA").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "모니터/프린터"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_digitalB").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "PC주변기기"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_digitalC").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "저장장치"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_digitalD").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "스포츠의류/운동화"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_sportsA").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "등산/아웃도어/캠핑/낚시"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_sportsB").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "스포츠용품"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_sportsC").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "자전거/보드/기타레저"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_sportsD").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "화장품/향수"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_beautyA").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "바디/헤어"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_beautyB").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "가구DIY"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_lifeA").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "조명/인테리어"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_lifeB").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "침구/커튼"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_lifeC").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "생활용품"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_lifeD").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "자동차용품"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_carA").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "공구/안전/산업용품"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_carB").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "도서/교육/음반"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_bookA").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "백화점/제화상품권"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_bookB").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "여행/항공권"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookD").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_bookC").classList;
                classList.remove("hidden");
            }
            else if(mcategory.innerText === "e쿠폰/모바일상품권"){
                document.querySelector("div.goods_Scategory_clothA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_clothC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_accD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_hobbyD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_digitalD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_sportsD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_beautyB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeC").classList.add("hidden");
				document.querySelector("div.goods_Scategory_lifeD").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_carB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookA").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookB").classList.add("hidden");
				document.querySelector("div.goods_Scategory_bookC").classList.add("hidden");
                const classList = document.querySelector("div.goods_Scategory_bookD").classList;
                classList.remove("hidden");
            }

            let selectedCategory = document.querySelector(".goods_category_area span.selected_category").innerText.split(" ");
            document.querySelector(".goods_category_area span.selected_category").innerText = selectedCategory[0] + " > " + this.innerText;
        });
    });

    document.querySelectorAll("div[class^='goods_Scategory'] > div").forEach(scategory => {
        scategory.addEventListener("click", function() {
            const children = this.parentElement.children
            for (let i = 0; i < children.length; i++) {
                children[i].removeAttribute("class");
            }
            this.classList.add("selected");

            document.querySelector(".goods_category").style.borderColor="rgb(220, 219, 228)";
            document.querySelector(".goods_category + p").classList.add("hidden");
            

            let selectedCategory = document.querySelector(".goods_category_area span.selected_category").innerText.split(" ");
            document.querySelector(".goods_category_area span.selected_category").innerText = selectedCategory[0] + " > " + selectedCategory[2] + " > " + this.innerText;
        });
    });
    document.querySelector(".goods_tag > input").addEventListener("keyup", tagAdd);
    document.querySelector(".checkbox_safePay > input[type='checkbox']").addEventListener("click", thunerPay);
});
let cnt = 0;
function setImages(event){
    
    		const currentInputName = event.target.name;
		  const currentInput = document.getElementsByName(currentInputName)[0];
		
		  currentInput.setAttribute("hidden", true);
//		
		  const nextInputName = "image" + (parseInt(currentInputName.substring(5)) + 1);
		  const nextInput = document.getElementsByName(nextInputName)[0];
//		
		  if (nextInput) {
		    nextInput.removeAttribute("hidden");
		  }
		
    for(var image of event.target.files){
        if(cnt >= 4){ // 이미지 파일 4개 카운팅 되면 나감
            alert("이미지 갯수를 확인해주세요!");
            document.getElementById(currentInputName).value = null;
            break;
        } else {
	        var reader = new FileReader();
	        
	        reader.onload = function(event){
		
	            var li = document.createElement("li");
	            li.setAttribute("draggable","false");
	            li.setAttribute("class","sc-gkFcWv iiYIYa");
	            var img = document.createElement("img");
//	            var img = ''
	            img.setAttribute("src", event.target.result);
	            img.setAttribute("class", "preview");
	            var button = document.createElement("button");
	            button.setAttribute("class", "eHGbgX");
	            button.setAttribute("type", "button");
	            button.addEventListener("click", function () {
//				alert(currentInputName);
//				document.getElementById(currentInputName).value = null;
				document.getElementById(currentInputName).value = null;
		          li.remove();
		          cnt -= 1;
		          document.querySelector(".image_num").innerText = cnt;
		        });
	            li.appendChild(img);
				li.appendChild(button);
	            document.querySelector("div.preview_wrap").appendChild(li);
	            cnt += 1;
	            document.querySelector(".image_num").innerText = cnt;
	            
//	            
	        };
	        
	        reader.readAsDataURL(image);
		}
    } // 포문 끝
    
}

function countTitleLength(event) {
    document.querySelector("span.goods_title_length span").innerText = event.target.value.length;
}

function countInfoLength(event) {
    document.querySelector("span.info_length span").innerText = event.target.value.length;
}

function valueIsNumber(event){
    event.target.value = event.target.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
}

function tagDelete(event) {
    let lastParent = event.target;
    while(true){
        lastParent =  lastParent.parentElement;
        if(lastParent.className === "tag_button"){
            lastParent.replaceChildren();
            lastParent.remove()
            break;
        }
    }
}


function tagAdd(event){
    if(event.keyCode == 32){
        const tag_button = document.querySelectorAll(".tag_button").length;
        if(tag_button >= 6){
            alert("태그는 최대 5개까지만 입력가능합니다");
        } else{
            event.preventDefault();
            let tagBtn = document.querySelector("div.tag_button").cloneNode(true);
            tagBtn.children[0].innerText = event.target.value;
            tagBtn.classList.remove("hidden");
            console.log(tag_button.valueOf.name);
            document.querySelector("div.goods_tag").insertBefore(tagBtn, this);
            event.target.value = "";
            alert(tagBtn);
        }
    }
}

function thunerPay() {
    if(this.checked){
        document.querySelectorAll("div.safe_pay_notice span.check").forEach(check => {
            check.style.borderLeftColor="#ff5058"
            check.style.borderBottomColor="#ff5058"
        })
    } else{
        document.querySelectorAll("div.safe_pay_notice span.check").forEach(check => {

            check.style.borderLeftColor="rgb(250, 250, 253)"
            check.style.borderBottomColor="rgb(250, 250, 253)"
        })
    }
}