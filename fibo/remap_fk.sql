ALTER TABLE action_transaction DROP CONSTRAINT action_transaction_pkey;
ALTER TABLE public.action_transaction ADD COLUMN action_transaction_id BIGSERIAL PRIMARY KEY;
CREATE UNIQUE INDEX uqc_act_type_id ON action_transaction (action_type, action_id, tx_hash);

ALTER TABLE collection ALTER COLUMN collection_id TYPE BIGINT;

ALTER TABLE collection_policy ALTER COLUMN collection_id TYPE BIGINT;

ALTER TABLE external_metadata DROP CONSTRAINT external_metadata_pkey;
ALTER TABLE public.external_metadata ADD COLUMN fingerprint_id BIGSERIAL PRIMARY KEY;
CREATE UNIQUE INDEX uqc_ext_finger ON external_metadata (fingerprint);

ALTER TABLE action_transaction DROP CONSTRAINT action_transaction_user_id_fkey;
ALTER TABLE collection  DROP CONSTRAINT collection_owner_fkey;
ALTER TABLE nft  DROP CONSTRAINT nft_author_fkey;
ALTER TABLE offer_event  DROP CONSTRAINT offer_event_user_id_fkey;
ALTER TABLE offer  DROP CONSTRAINT offer_seller_fkey;
ALTER TABLE pending_sell  DROP CONSTRAINT pending_sell_seller_fkey;
ALTER TABLE promotion_object  DROP CONSTRAINT promotion_object_profile_id_fkey;
ALTER TABLE reviewer  DROP CONSTRAINT reviewer_reviewer_id_fkey;

ALTER TABLE user_profile DROP CONSTRAINT user_profile_pkey;
ALTER TABLE public.user_profile ADD COLUMN user_profile_id BIGSERIAL PRIMARY KEY;
ALTER TABLE user_profile DROP CONSTRAINT user_profile_profile_bg_image_id_fkey;
ALTER TABLE user_profile DROP CONSTRAINT user_profile_profile_image_id_fkey;
ALTER TABLE image_moderation DROP CONSTRAINT image_moderation_pkey;
ALTER TABLE public.image_moderation ADD COLUMN image_moderation_id BIGSERIAL PRIMARY KEY;
CREATE UNIQUE INDEX uqc_image_finger ON image_moderation (id);
ALTER TABLE user_profile ADD COLUMN profile_bg_image_big_id BIGINT REFERENCES image_moderation(image_moderation_id);
-- ALTER TABLE user_profile ADD CONSTRAINT user_profile_profile_bg_image_id_fkey FOREIGN KEY (profile_bg_image_id) REFERENCES image_moderation (image_moderation_id);
ALTER TABLE user_profile ADD COLUMN profile_image_big_id BIGINT REFERENCES image_moderation(image_moderation_id);
-- ALTER TABLE user_profile ADD CONSTRAINT user_profile_profile_image_id_fkey FOREIGN KEY (profile_bg_image_id) REFERENCES image_moderation (image_moderation_id);
CREATE UNIQUE INDEX uqc_user_profile_id ON user_profile(profile_id);

ALTER TABLE action_transaction ADD COLUMN user_profile_id BIGINT REFERENCES user_profile(user_profile_id);
-- ALTER TABLE action_transaction ADD CONSTRAINT action_transaction_user_id_fkey FOREIGN KEY (user_id) REFERENCES user_profile(user_profile_id);
ALTER TABLE collection ADD COLUMN owner_id BIGINT REFERENCES user_profile(user_profile_id);
-- ALTER TABLE collection ADD CONSTRAINT collection_owner_fkey FOREIGN KEY (owner) REFERENCES user_profile(user_profile_id);
ALTER TABLE nft ADD COLUMN author_id BIGINT REFERENCES user_profile(user_profile_id);
-- ALTER TABLE nft ADD CONSTRAINT nft_author_fkey FOREIGN KEY (author) REFERENCES user_profile(user_profile_id);
ALTER TABLE offer_event ADD COLUMN user_big_id BIGINT REFERENCES user_profile(user_profile_id);
-- ALTER TABLE offer_event ADD CONSTRAINT offer_event_user_id_fkey FOREIGN KEY (user_id) REFERENCES user_profile(user_profile_id);
ALTER TABLE offer ADD COLUMN user_big_id BIGINT REFERENCES user_profile(user_profile_id);
-- ALTER TABLE offer ADD CONSTRAINT offer_seller_fkey FOREIGN KEY (seller_id) REFERENCES user_profile(user_profile_id);
ALTER TABLE pending_sell ADD COLUMN seller_id BIGINT REFERENCES user_profile(user_profile_id);
-- ALTER TABLE pending_sell ADD CONSTRAINT pending_sell_seller_fkey FOREIGN KEY (seller) REFERENCES user_profile(user_profile_id);
ALTER TABLE promotion_object ADD COLUMN profile_big_id BIGINT REFERENCES user_profile(user_profile_id);
-- ALTER TABLE promotion_object ADD CONSTRAINT promotion_object_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES user_profile(user_profile_id);
ALTER TABLE reviewer ADD COLUMN user_profile_id BIGINT REFERENCES user_profile(user_profile_id);
-- ALTER TABLE reviewer ADD CONSTRAINT reviewer_reviewer_id_fkey FOREIGN KEY (reviewer_id) REFERENCES user_profile(user_profile_id);

ALTER TABLE external_metadata DROP CONSTRAINT external_metadata_fingerprint_fkey;
ALTER TABLE offer DROP CONSTRAINT offer_nft_fingerprint_fkey;
ALTER TABLE promotion_object DROP CONSTRAINT promotion_object_nft_fingerprint_fkey;
ALTER TABLE nft DROP CONSTRAINT nft_pkey;
ALTER TABLE public.nft ADD COLUMN nft_id BIGSERIAL PRIMARY KEY;
CREATE UNIQUE INDEX uqc_nft_finger ON nft(fingerprint);
ALTER TABLE external_metadata ADD COLUMN nft_id BIGINT REFERENCES nft(nft_id);
-- ALTER TABLE external_metadata ADD CONSTRAINT external_metadata_fingerprint_fkey FOREIGN KEY (fingerprint_id) REFERENCES nft(fingerprint_id);
ALTER TABLE offer ADD COLUMN nft_id BIGINT REFERENCES nft(nft_id);
-- ALTER TABLE offer ADD CONSTRAINT offer_nft_fingerprint_fkey FOREIGN KEY (nft_fingerprint) REFERENCES nft(fingerprint_id);
ALTER TABLE promotion_object ADD COLUMN nft_id BIGINT REFERENCES nft(nft_id);
-- ALTER TABLE promotion_object ADD CONSTRAINT promotion_object_nft_fingerprint_fkey FOREIGN KEY (nft_fingerprint) REFERENCES nft(fingerprint_id);


ALTER TABLE nft_draft_image DROP CONSTRAINT fk_nft_draft_nft_image_draft;
ALTER TABLE nft_draft_image DROP CONSTRAINT nft_draft_image_pkey;
ALTER TABLE nft_draft DROP CONSTRAINT nft_draft_pkey;
ALTER TABLE public.nft_draft_image ADD COLUMN nft_draft_image_id BIGSERIAL PRIMARY KEY;
CREATE UNIQUE INDEX uqc_nft_draft_image ON nft_draft(draft_image_id);
ALTER TABLE nft_draft_image ADD CONSTRAINT fk_nft_draft_nft_image_draft FOREIGN KEY (cid) REFERENCES nft_draft(draft_image_id) ON DELETE CASCADE;


ALTER TABLE nft_in_review_sent_notification DROP CONSTRAINT nft_in_review_sent_notification_pkey;
ALTER TABLE public.nft_in_review_sent_notification ADD COLUMN nft_in_review_sent_notification_id BIGSERIAL PRIMARY KEY;
CREATE UNIQUE INDEX uqc_nft_in_finger ON nft_in_review_sent_notification(fingerprint);

ALTER TABLE offer alter column offer_id type bigint;
ALTER TABLE offer_event alter column offer_id type bigint;
 
ALTER TABLE pending_sell DROP CONSTRAINT pending_sell_pkey;
ALTER TABLE public.pending_sell ADD COLUMN pending_sell_id BIGSERIAL PRIMARY KEY;
CREATE UNIQUE INDEX uqc_pending_id ON pending_sell(id);
 
ALTER TABLE promotion_object DROP CONSTRAINT promotion_object_promotion_id_fkey;
ALTER TABLE promotion DROP CONSTRAINT promotion_pkey;
ALTER TABLE public.promotion ADD COLUMN promotion_id BIGSERIAL PRIMARY KEY;
CREATE UNIQUE INDEX uqc_promotion_id ON promotion(id);
   
ALTER TABLE public.promotion_object ADD COLUMN promotion_object_id BIGSERIAL PRIMARY KEY;
ALTER TABLE promotion_object ADD constraint promotion_object_promotion_id_fkey FOREIGN KEY (promotion_object_id) REFERENCES promotion(promotion_id);
   
ALTER TABLE red_image DROP CONSTRAINT red_image_pkey;
ALTER TABLE public.red_image ADD COLUMN red_image_id BIGSERIAL PRIMARY KEY;
CREATE UNIQUE INDEX uqc_red_image_id ON red_image(cid);

ALTER TABLE reviewer DROP CONSTRAINT reviewer_pkey;
ALTER TABLE public.reviewer ADD COLUMN reviewer_big_id BIGSERIAL PRIMARY KEY;
CREATE UNIQUE INDEX uqc_reviewer_id ON reviewer(reviewer_id);

ALTER TABLE text_moderation DROP CONSTRAINT text_moderation_pkey;
ALTER TABLE public.text_moderation ADD COLUMN text_moderation_id BIGSERIAL PRIMARY KEY;
CREATE UNIQUE INDEX uqc_text_id ON text_moderation(id);



-- ALTER TABLE action_transaction ADD COLUMN user_profile_id BIGINT REFERENCES user_profile(user_profile_id);
-- ALTER TABLE collection ADD COLUMN collection_id BIGINT REFERENCES user_profile(user_profile_id);
ALTER TABLE collection_policy ADD COLUMN collection_policy_id BIGINT REFERENCES collection(collection_id);
ALTER TABLE external_metadata ADD COLUMN external_metadata_id BIGINT REFERENCES nft(nft_id);
-- ALTER TABLE nft ADD COLUMN nft_id BIGINT REFERENCES user_profile(user_profile_id);
-- ALTER TABLE nft_draft ADD COLUMN nft_draft_id BIGINT REFERENCES collection(collection_big_id);
-- ALTER TABLE nft_draft_image ADD COLUMN nft_draft_image_id BIGINT REFERENCES nft_draft(draft_image_id) ON DELETE CASCADE;
-- ALTER TABLE offer ADD COLUMN offer_id BIGINT REFERENCES nft(nft_id);
-- ALTER TABLE offer ADD COLUMN offer_id BIGINT REFERENCES user_profile(user_profile_id);
-- ALTER TABLE offer_event ADD COLUMN offer_id BIGINT REFERENCES offer(offer_id);
ALTER TABLE offer_event ADD user_profile_id BIGINT REFERENCES user_profile(user_profile_id);
ALTER TABLE pending_sell ADD COLUMN user_profile_id BIGINT REFERENCES user_profile(user_profile_id);
ALTER TABLE promotion_object ADD COLUMN collection_big_id BIGINT REFERENCES collection(collection_id);
-- ALTER TABLE promotion_object ADD COLUMN nft_id BIGINT REFERENCES nft(nft_id);
ALTER TABLE promotion_object ADD COLUMN user_profile_id BIGINT REFERENCES user_profile(user_profile_id);
ALTER TABLE promotion_object ADD COLUMN promotion_big_id BIGINT REFERENCES promotion(promotion_id);
-- ALTER TABLE reviewer ADD COLUMN user_profile_id BIGINT REFERENCES user_profile(user_profile_id);
-- ALTER TABLE user_profile ADD COLUMN image_moderation_id BIGINT REFERENCES image_moderation(image_moderation_id);
