const permissionsPage = new Vue({
    el: "#home_page",
    data: {
        photos: [],
        currentImageUrl: '',
        currentIndex: 0,
    },
    created() {
        this.loadPhotos();
    },
    methods: {
        loadPhotos() {
            helper.get("/Home/GetImages",
                {},
                (response) => {
                    if (response.success) {
                        this.photos = response.data;
                        this.currentIndex = 0;
                        this.updateImage();
                    }
                })
        },
        updateImage() {
            this.currentImageUrl = this.photos[this.currentIndex].url;
        },
        onNextClicked() {
            if (this.currentIndex < this.photos.length - 1) {
                this.currentIndex += 1;
            } else {
                this.currentIndex = 0;
            }
            this.updateImage();
        },
        onPrevClicked() {
            if (this.currentIndex > 0) {
                this.currentIndex -= 1;
            } else {
                this.currentIndex = this.photos.length - 1;
            }
            this.updateImage();
        }
    },
});
