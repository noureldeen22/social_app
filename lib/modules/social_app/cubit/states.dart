abstract class SocialStates {}

class SocialInitialState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates
{
 final String error;

  SocialGetUserErrorState(this.error);
}

//chat screen
class SocialGetAllUsersSuccessState extends SocialStates{}

class SocialGetAllUsersLoadingState extends SocialStates{}

class SocialGetAllUsersErrorState extends SocialStates
{
 final String error;

  SocialGetAllUsersErrorState(this.error);
}

class SocialGetPostSuccessState extends SocialStates{}

class SocialGetPostLoadingState extends SocialStates{}

class SocialGetPostErrorState extends SocialStates
{
 final String error;

  SocialGetPostErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}

class SocialUserUpdateLoadingState extends SocialStates{}

//create post

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}

class SocialRemovePostImageState extends SocialStates{}

//like post

class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates{}

//chat

class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{}

class SocialGetMessageSuccessState extends SocialStates{}

class SocialGetMessageErrorState extends SocialStates{}

//imageMessage
class SocialMessageImagePickedSuccessState extends SocialStates{}

class SocialMessageImagePickedErrorState extends SocialStates{}

//uploadImageMessage

class SocialCreateMessageImageLoadingState extends SocialStates{}

class SocialCreateMessageImageSuccessState extends SocialStates{}

class SocialCreateMessageImageErrorState extends SocialStates{}