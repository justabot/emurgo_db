work_mem = '1GB';
EXPLAIN (ANALYZE, BUFFERS)
 SELECT COUNT(*) as total_count FROM (select "collection".*, "collection_policy"."policy_id", "collection_policy"."policy_pubkey", "collection_policy"."locking_slot",                                                                                                               
       (            
         SELECT COUNT(*)                                                                                                                                                                                                                                                                   
         from nft   
         WHERE nft.policy_id = collection_policy.policy_id                                                                                                                                                                                                                                 
       ) as nft_count
     ,              
       (            
         SELECT image_cid                                                                                                                                                                                                                                                                  
         from nft   
         WHERE nft.policy_id = collection_policy.policy_id                                                                                                                                                                                                                                 
         ORDER BY nft.created_at ASC                                                                                                                                                                                                                                                       
         LIMIT 1    
       ) as cover_cid
      from "collection" left join "collection_policy" on "collection_policy"."collection_id" = "collection"."collection_id" where "collection"."name" is not null and collection.name ILIKE '%r%' and                                                                                    
         (          
           SELECT COUNT(*)                                                                                                                                                                                                                                                                 
           from nft 
           WHERE nft.policy_id = collection_policy.policy_id                                                                                                                                                                                                                               
         ) > 0      
       ) as results;
     
                    
       SELECT COUNT(*) as total_count FROM (select "user_profile".*,                                                                                                                                                                                                                       
       (            
         SELECT COUNT(*)                                                                                                                                                                                                                                                                   
         from nft   
         WHERE nft.author = user_profile.profile_id                                                                                                                                                                                                                                        
       ) as nft_count
      from "user_profile" where "user_profile"."name" ilike '%ref%') as results;                                                                                                                                                                                                                                                        